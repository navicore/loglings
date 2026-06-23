//! Shells out to `plgc run` to check an exercise file. `plgc` is the Prolog
//! compiler from the `patch-prolog` project (crate `plg-compiler`); it
//! compiles the file to a temp binary and runs it (it never interprets), so
//! `clang` must be on PATH too.
//!
//! Exit-code contract (from `plgc run`):
//!   0 = goal produced no solutions (test failed)
//!   1 = goal produced ≥1 solution (test passed)
//!   2 = parse error
//!   3 = runtime error (uncaught throw, step limit, etc.)

use crate::bisect::{self, Blame, Probe};
use std::path::Path;
use std::process::Command;

const PLGC: &str = "plgc";

#[derive(Debug)]
pub enum CheckOutcome {
    /// Test passed (exit 1: goal succeeded).
    Passed,
    /// Test failed (exit 0: goal had no solutions). `stderr` captured for display.
    Failed(String),
    /// Parse error in the exercise file (exit 2). String is the engine's error JSON/text.
    ParseError(String),
    /// Runtime error from the engine (exit 3).
    RuntimeError(String),
    /// `plgc` itself failed to invoke (binary missing, etc.).
    InvocationError(String),
}

/// Run `goal` against the exercise file. For parse-only exercises, pass `"true"`
/// — it succeeds iff the file parses; otherwise `plgc` exits with code 2.
/// For test-mode exercises, the hidden checker section should define `test/0`
/// and the goal is `"test"`.
pub fn check(file: &Path, goal: &str) -> CheckOutcome {
    let output = Command::new(PLGC)
        .arg("run")
        .arg(file)
        .arg("--query")
        .arg(goal)
        .arg("--format")
        .arg("text")
        .output();

    let output = match output {
        Ok(o) => o,
        Err(e) => {
            return CheckOutcome::InvocationError(format!(
                "Failed to run `{PLGC}`: {e}. Is `{PLGC}` installed and on your PATH? (It ships with the `patch-prolog` project; it also needs `clang`.)"
            ));
        }
    };

    let stdout = String::from_utf8_lossy(&output.stdout).to_string();
    let stderr = String::from_utf8_lossy(&output.stderr).to_string();
    let combined = if stderr.is_empty() {
        stdout.clone()
    } else if stdout.is_empty() {
        stderr.clone()
    } else {
        format!("{stdout}\n{stderr}")
    };

    match output.status.code() {
        Some(1) => CheckOutcome::Passed,
        Some(0) => CheckOutcome::Failed(combined),
        Some(2) => CheckOutcome::ParseError(combined),
        Some(3) => CheckOutcome::RuntimeError(combined),
        other => CheckOutcome::InvocationError(format!(
            "Unexpected `{PLGC}` exit code {other:?}: {combined}"
        )),
    }
}

/// Given a `test/0` that just failed, find the first check in its conjunction
/// that has no solution, so the learner can be pointed at the right line.
///
/// Runs cumulative prefixes (`g1`, `g1, g2`, ...) — not isolated checks —
/// because checks thread variables. Probes are bounded to ~log₂N by binary
/// search and only ever happen on a failing test. Returns `None` whenever the
/// checker isn't a single flat conjunction or a probe is inconclusive, in which
/// case the caller keeps the original opaque message.
pub fn bisect_failure(file: &Path, content: &str) -> Option<Blame> {
    let conjuncts = bisect::extract_test_body(content)?;
    let total = conjuncts.len();
    let index = bisect::first_failing(total, |k| {
        let prefix = conjuncts[..k]
            .iter()
            .map(|c| c.text.as_str())
            .collect::<Vec<_>>()
            .join(", ");
        match check(file, &prefix) {
            CheckOutcome::Passed => Probe::Provable,
            CheckOutcome::Failed(_) => Probe::Unprovable,
            _ => Probe::Inconclusive,
        }
    })?;
    let c = &conjuncts[index - 1];
    Some(Blame {
        index,
        total,
        line: c.line,
        goal: c.text.clone(),
    })
}

#[cfg(test)]
mod plgc_tests {
    //! End-to-end blame against the real `plgc` (a hard dependency, like the
    //! semantic tier in `tests/curriculum.rs`).
    use super::*;
    use std::io::Write;

    fn write_temp(name: &str, content: &str) -> std::path::PathBuf {
        let mut p = std::env::temp_dir();
        p.push(format!("loglings_bisect_{}_{name}.pl", std::process::id()));
        std::fs::File::create(&p)
            .unwrap()
            .write_all(content.as_bytes())
            .unwrap();
        p
    }

    #[test]
    fn blames_the_missing_else_branch() {
        // action/2 lacks the final `; A = go`, so `action(green, go)` (check 3)
        // has no solution — exactly the bug a learner hit.
        let content = "\
action(Light, A) :- ( Light = red -> A = stop ; Light = yellow -> A = slow ).
warn(Light) :- ( Light = red ; Light = yellow ).
crossable(Light) :- \\+ action(Light, stop).

% Do not edit below this line

test :-
    action(red, stop),
    action(yellow, slow),
    action(green, go),
    warn(red),
    warn(yellow),
    \\+ warn(green),
    crossable(green),
    crossable(yellow),
    \\+ crossable(red).
";
        let file = write_temp("missing_else", content);
        let blame = bisect_failure(&file, content).expect("a failing check");
        assert_eq!(blame.goal, "action(green, go)");
        assert_eq!(blame.index, 3);
        assert_eq!(blame.total, 9);
        let _ = std::fs::remove_file(&file);
    }

    #[test]
    fn blames_the_equality_not_the_findall_before_it() {
        // The `findall` succeeds and binds S; the `==` is what fails. This only
        // lands correctly because we probe cumulative prefixes (S stays bound),
        // not isolated goals.
        let content = "\
book(dune, sci_fi).
book(hobbit, fantasy).
titles_in(Genre, Titles) :- findall(T, book(T, Genre), Titles).

% Do not edit below this line

test :-
    titles_in(sci_fi, S),
    S == [dune, hobbit].
";
        let file = write_temp("threaded_var", content);
        let blame = bisect_failure(&file, content).expect("a failing check");
        assert_eq!(blame.goal, "S == [dune, hobbit]");
        assert_eq!(blame.index, 2);
        let _ = std::fs::remove_file(&file);
    }
}
