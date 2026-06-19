//! Bisecting a failed `test/0` to the first check that has no solution.
//!
//! A `mode = "test"` exercise's checker is a single clause
//! `test :- g1, g2, ..., gN.`. When `plgc` reports the whole thing as a bare
//! `false.`, this module finds *which* `gK` first fails so the watcher can
//! point the learner at the right check instead of an opaque failure.
//!
//! The search runs cumulative *prefixes* (`g1`, then `g1, g2`, ...), never
//! isolated goals, because checks thread variables
//! (`titles_in(sci_fi, S), S == [...]` — running `S == [...]` alone sees an
//! unbound `S`). Prefix-provability is monotone — once a prefix has no solution
//! no longer prefix can — so the first failing check is found by binary search.
//!
//! Everything here is pure (string parsing + a search over an injected probe);
//! the `plgc` calls live in `runner::bisect_failure`, which feeds this module.

/// One goal from the top-level conjunction of a `test/0` body.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Conjunct {
    /// The goal text, whitespace-normalized and comment-free.
    pub text: String,
    /// 1-based source line in the exercise file where the goal starts.
    pub line: usize,
}

/// Whether a prefix of checks is provable, per one `plgc` probe.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Probe {
    Provable,
    Unprovable,
    /// The probe errored (parse/runtime) — bisection can't trust the result.
    Inconclusive,
}

/// The check blamed for a test failure.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Blame {
    /// 1-based position of the failing check in the conjunction.
    pub index: usize,
    pub total: usize,
    pub line: usize,
    pub goal: String,
}

const FOLD: &str = "% Do not edit below this line";

fn is_ident_char(c: char) -> bool {
    c.is_alphanumeric() || c == '_'
}

/// Extract the top-level conjuncts of the single hidden `test :- ...` clause.
///
/// Returns `None` (caller falls back to the opaque message) when the checker
/// isn't a single flat conjunction we can reason about: no `test/0`, more than
/// one `test` clause, or fewer than two checks (nothing to bisect).
pub fn extract_test_body(content: &str) -> Option<Vec<Conjunct>> {
    let (region, base_line) = match content.find(FOLD) {
        Some(i) => (&content[i..], content[..i].matches('\n').count() + 1),
        None => (content, 1),
    };
    let head = find_test_head(region)?;
    let body_end = find_clause_end(&region[head..])?;
    let body = &region[head..head + body_end];
    // A second `test :-` after this clause means a multi-clause test/0 we
    // can't bisect as one conjunction — bail to the fallback message.
    if find_test_head(&region[head + body_end..]).is_some() {
        return None;
    }
    let body_start_line = base_line + region[..head].matches('\n').count();
    let conjuncts = split_conjuncts(body, body_start_line);
    if conjuncts.len() < 2 {
        return None;
    }
    Some(conjuncts)
}

/// Byte offset just past the `:-` of a `test :-` clause head, if present.
fn find_test_head(s: &str) -> Option<usize> {
    let mut from = 0;
    while let Some(rel) = s[from..].find("test") {
        let at = from + rel;
        let before_ok = s[..at].chars().last().is_none_or(|c| !is_ident_char(c));
        let after = &s[at + 4..];
        let boundary = after.chars().next().is_none_or(|c| !is_ident_char(c));
        if before_ok && boundary {
            let trimmed = after.trim_start();
            if trimmed.starts_with(":-") {
                let ws = after.len() - trimmed.len();
                return Some(at + 4 + ws + 2);
            }
        }
        from = at + 4;
    }
    None
}

/// Byte offset of the clause-terminating `.` (a `.` at nesting depth 0,
/// outside quotes, followed by whitespace or end of input).
fn find_clause_end(s: &str) -> Option<usize> {
    let mut depth: i32 = 0;
    let mut quote: Option<char> = None;
    let mut escaped = false;
    let mut iter = s.char_indices().peekable();
    while let Some((i, c)) = iter.next() {
        if let Some(q) = quote {
            if escaped {
                escaped = false;
            } else if c == '\\' {
                escaped = true;
            } else if c == q {
                quote = None;
            }
            continue;
        }
        match c {
            '\'' | '"' | '`' => quote = Some(c),
            '(' | '[' | '{' => depth += 1,
            ')' | ']' | '}' => depth -= 1,
            '%' => {
                while let Some(&(_, n)) = iter.peek() {
                    if n == '\n' {
                        break;
                    }
                    iter.next();
                }
            }
            '.' if depth == 0 && iter.peek().is_none_or(|&(_, n)| n.is_whitespace()) => {
                return Some(i);
            }
            _ => {}
        }
    }
    None
}

/// Split a conjunction body on top-level commas, normalizing whitespace and
/// dropping `%` comments. Commas inside `()`/`[]`/`{}` or quotes don't split.
fn split_conjuncts(body: &str, start_line: usize) -> Vec<Conjunct> {
    let mut out = Vec::new();
    let mut depth: i32 = 0;
    let mut quote: Option<char> = None;
    let mut escaped = false;
    let mut line = start_line;
    let mut cur_line = start_line;
    let mut started = false;
    let mut text = String::new();

    let mut iter = body.chars().peekable();
    while let Some(c) = iter.next() {
        let is_nl = c == '\n';
        if let Some(q) = quote {
            if !started {
                cur_line = line;
                started = true;
            }
            text.push(c);
            if escaped {
                escaped = false;
            } else if c == '\\' {
                escaped = true;
            } else if c == q {
                quote = None;
            }
            if is_nl {
                line += 1;
            }
            continue;
        }
        match c {
            '%' => {
                while let Some(&n) = iter.peek() {
                    if n == '\n' {
                        break;
                    }
                    iter.next();
                }
            }
            ',' if depth == 0 => {
                out.push(Conjunct {
                    text: text.trim_end().to_string(),
                    line: cur_line,
                });
                text.clear();
                started = false;
            }
            c if c.is_whitespace() => {
                if started && !text.ends_with(' ') {
                    text.push(' ');
                }
            }
            _ => {
                if !started {
                    cur_line = line;
                    started = true;
                }
                if matches!(c, '(' | '[' | '{') {
                    depth += 1;
                } else if matches!(c, ')' | ']' | '}') {
                    depth -= 1;
                } else if matches!(c, '\'' | '"' | '`') {
                    quote = Some(c);
                }
                text.push(c);
            }
        }
        if is_nl {
            line += 1;
        }
    }
    let last = text.trim_end().to_string();
    if !last.is_empty() {
        out.push(Conjunct {
            text: last,
            line: cur_line,
        });
    }
    out
}

/// Binary-search for the 1-based index of the first prefix that fails.
///
/// Precondition: the full conjunction (prefix of length `n`) is known
/// unprovable — that's *why* we're bisecting — so length `n` is never probed.
/// `provable(k)` answers whether the first `k` checks together have a solution;
/// monotonicity (a failed prefix stays failed) makes the search valid. Returns
/// `None` if `n == 0` or any probe is inconclusive.
pub fn first_failing(n: usize, mut provable: impl FnMut(usize) -> Probe) -> Option<usize> {
    if n == 0 {
        return None;
    }
    let mut lo = 1;
    let mut hi = n;
    while lo < hi {
        let mid = usize::midpoint(lo, hi);
        match provable(mid) {
            Probe::Provable => lo = mid + 1,
            Probe::Unprovable => hi = mid,
            Probe::Inconclusive => return None,
        }
    }
    Some(lo)
}

#[cfg(test)]
mod tests {
    use super::*;

    fn texts(cs: &[Conjunct]) -> Vec<&str> {
        cs.iter().map(|c| c.text.as_str()).collect()
    }

    #[test]
    fn splits_simple_conjunction() {
        let cs = split_conjuncts("a, b, c", 1);
        assert_eq!(texts(&cs), ["a", "b", "c"]);
    }

    #[test]
    fn commas_inside_parens_do_not_split() {
        let cs = split_conjuncts("action(red, stop), warn(red)", 1);
        assert_eq!(texts(&cs), ["action(red, stop)", "warn(red)"]);
    }

    #[test]
    fn commas_inside_lists_and_findall_do_not_split() {
        let cs = split_conjuncts("findall(X, foo(X), L), L == [a, b, c]", 1);
        assert_eq!(texts(&cs), ["findall(X, foo(X), L)", "L == [a, b, c]"]);
    }

    #[test]
    fn if_then_else_is_one_conjunct() {
        let cs = split_conjuncts("( L = red -> A = stop ; A = go )", 1);
        assert_eq!(texts(&cs), ["( L = red -> A = stop ; A = go )"]);
    }

    #[test]
    fn whitespace_and_newlines_are_normalized() {
        let cs = split_conjuncts("a(1),\n    b(2),\n    c(3)", 1);
        assert_eq!(texts(&cs), ["a(1)", "b(2)", "c(3)"]);
    }

    #[test]
    fn line_comments_are_dropped() {
        let cs = split_conjuncts("a, % skip me\n    b", 1);
        assert_eq!(texts(&cs), ["a", "b"]);
    }

    #[test]
    fn extract_tracks_source_lines() {
        // line 1: prose, 2: fold, 3: blank, 4: head, 5..7: checks
        let content = "\
% prose line
% Do not edit below this line

test :-
    action(red, stop),
    warn(red),
    crossable(green).
";
        let cs = extract_test_body(content).expect("flat conjunction");
        assert_eq!(
            texts(&cs),
            ["action(red, stop)", "warn(red)", "crossable(green)"]
        );
        assert_eq!(cs[0].line, 5);
        assert_eq!(cs[1].line, 6);
        assert_eq!(cs[2].line, 7);
    }

    #[test]
    fn extract_without_fold_scans_whole_file() {
        let content = "test :- a, b.\n";
        let cs = extract_test_body(content).expect("flat conjunction");
        assert_eq!(texts(&cs), ["a", "b"]);
        assert_eq!(cs[0].line, 1);
    }

    #[test]
    fn multi_clause_test_bails() {
        let content = "test :- a, b.\ntest :- c, d.\n";
        assert_eq!(extract_test_body(content), None);
    }

    #[test]
    fn single_check_is_not_worth_bisecting() {
        let content = "test :- only_one_check.\n";
        assert_eq!(extract_test_body(content), None);
    }

    #[test]
    fn no_test_clause_bails() {
        let content = "greeted :- a, b.\n";
        assert_eq!(extract_test_body(content), None);
    }

    #[test]
    fn test_substring_in_other_predicate_is_not_a_head() {
        let content = "latest :- a, b.\ntest :- c, d.\n";
        let cs = extract_test_body(content).expect("real test clause");
        assert_eq!(texts(&cs), ["c", "d"]);
    }

    #[test]
    fn first_failing_finds_the_broken_check() {
        // checks 1..2 provable, 3 onward not — blame is 3.
        let idx = first_failing(5, |k| {
            if k < 3 {
                Probe::Provable
            } else {
                Probe::Unprovable
            }
        });
        assert_eq!(idx, Some(3));
    }

    #[test]
    fn first_failing_blames_last_when_all_prefixes_hold() {
        // every proper prefix is provable; only the full conjunction fails.
        let idx = first_failing(4, |_| Probe::Provable);
        assert_eq!(idx, Some(4));
    }

    #[test]
    fn first_failing_blames_first_check() {
        let idx = first_failing(4, |_| Probe::Unprovable);
        assert_eq!(idx, Some(1));
    }

    #[test]
    fn first_failing_gives_up_on_inconclusive_probe() {
        assert_eq!(first_failing(4, |_| Probe::Inconclusive), None);
    }
}
