//! Curriculum tests — the real test surface for loglings.
//!
//! loglings has almost no Rust logic to unit-test; its correctness lives in the
//! Prolog corpus. These tests exercise that corpus on every `cargo test`.
//!
//! Tier 1 — structural (no engine): the registry is consistent, every exercise
//! has a solution + hint, starters carry the `% I AM NOT DONE` marker and
//! solutions don't, hints leak no answers, and no corpus file is orphaned.
//!
//! Tier 2 — semantic (needs `prlg`): every reference solution makes its hidden
//! `test/0` pass, and every starter parses, on the real engine. `prlg` is a hard
//! dependency of the project (CI installs a pinned `patch-prolog`; local
//! development already has it), so its absence is a test failure, not a skip.

use std::collections::HashSet;
use std::path::{Path, PathBuf};
use std::process::Command;

const NOT_DONE_MARKER: &str = "% I AM NOT DONE";

struct Entry {
    name: String,
    path: String, // relative to repo root, e.g. "exercises/02-terms/04-arity.pl"
    mode: String, // "test" | "parse"
}

fn root() -> PathBuf {
    PathBuf::from(env!("CARGO_MANIFEST_DIR"))
}

/// Minimal reader for the well-formed `[[exercises]]` registry — avoids pulling
/// a TOML crate into the (dependency-less) test target.
fn registry() -> Vec<Entry> {
    let text = std::fs::read_to_string(root().join("exercises/info.toml"))
        .expect("read exercises/info.toml");
    let mut out: Vec<Entry> = Vec::new();
    for line in text.lines() {
        let line = line.trim();
        if line == "[[exercises]]" {
            out.push(Entry {
                name: String::new(),
                path: String::new(),
                mode: "test".into(), // default mode, matches exercise.rs
            });
        } else if let Some(e) = out.last_mut() {
            if let Some(v) = value_of(line, "name") {
                e.name = v;
            } else if let Some(v) = value_of(line, "path") {
                e.path = v;
            } else if let Some(v) = value_of(line, "mode") {
                e.mode = v;
            }
        }
    }
    assert!(!out.is_empty(), "registry parsed no exercises");
    out
}

/// `key = "value"` -> `Some("value")`, else `None`.
fn value_of(line: &str, key: &str) -> Option<String> {
    let rest = line
        .strip_prefix(key)?
        .trim_start()
        .strip_prefix('=')?
        .trim();
    Some(rest.trim_matches('"').to_string())
}

fn solution_path(ex_path: &str) -> PathBuf {
    root().join(ex_path.replacen("exercises/", "solutions/", 1))
}

fn hint_path(ex_path: &str) -> PathBuf {
    let rel = ex_path
        .strip_prefix("exercises/")
        .expect("exercises/ prefix");
    root().join("hints").join(rel).with_extension("md")
}

fn collect(dir: &Path, ext: &str, out: &mut Vec<PathBuf>) {
    let Ok(rd) = std::fs::read_dir(dir) else {
        return;
    };
    for entry in rd.flatten() {
        let p = entry.path();
        if p.is_dir() {
            collect(&p, ext, out);
        } else if p.extension().and_then(|s| s.to_str()) == Some(ext) {
            out.push(p);
        }
    }
}

// ---------- Tier 1: structural ----------

#[test]
fn registry_is_consistent() {
    let reg = registry();
    let mut seen = HashSet::new();
    let mut errs = Vec::new();
    for e in &reg {
        if e.name.is_empty() || e.path.is_empty() {
            errs.push(format!(
                "incomplete entry: name={:?} path={:?}",
                e.name, e.path
            ));
        }
        if !seen.insert(e.name.clone()) {
            errs.push(format!("duplicate exercise name: {}", e.name));
        }
        if !matches!(e.mode.as_str(), "test" | "parse") {
            errs.push(format!("{}: unknown mode {:?}", e.name, e.mode));
        }
        if !root().join(&e.path).exists() {
            errs.push(format!("{}: missing exercise file {}", e.name, e.path));
        }
        if !solution_path(&e.path).exists() {
            errs.push(format!("{}: missing solution file", e.name));
        }
        if !hint_path(&e.path).exists() {
            errs.push(format!("{}: missing hint file", e.name));
        }
    }
    assert!(errs.is_empty(), "registry problems:\n{}", errs.join("\n"));
}

#[test]
fn starters_marked_solutions_clean() {
    let mut errs = Vec::new();
    for e in &registry() {
        let starter = std::fs::read_to_string(root().join(&e.path)).unwrap();
        if !starter.lines().any(|l| l.trim() == NOT_DONE_MARKER) {
            errs.push(format!(
                "{}: starter is missing the NOT DONE marker",
                e.name
            ));
        }
        let solution = std::fs::read_to_string(solution_path(&e.path)).unwrap();
        if solution.lines().any(|l| l.trim() == NOT_DONE_MARKER) {
            errs.push(format!(
                "{}: solution still carries the NOT DONE marker",
                e.name
            ));
        }
    }
    assert!(errs.is_empty(), "{}", errs.join("\n"));
}

#[test]
fn hints_do_not_leak_solutions() {
    let mut errs = Vec::new();
    for e in &registry() {
        let hint = std::fs::read_to_string(hint_path(&e.path)).unwrap();
        if hint.contains("## Solution sketch") {
            errs.push(format!("{}: hint still contains a Solution sketch", e.name));
        }
    }
    assert!(
        errs.is_empty(),
        "hints leaking answers:\n{}",
        errs.join("\n")
    );
}

#[test]
fn no_orphan_corpus_files() {
    let reg = registry();
    let expect = |sel: fn(&Entry) -> PathBuf| reg.iter().map(sel).collect::<HashSet<_>>();

    let checks = [
        ("exercises", "pl", expect(|e| root().join(&e.path))),
        ("solutions", "pl", expect(|e| solution_path(&e.path))),
        ("hints", "md", expect(|e| hint_path(&e.path))),
    ];
    let mut errs = Vec::new();
    for (tree, ext, expected) in checks {
        let mut found = Vec::new();
        collect(&root().join(tree), ext, &mut found);
        for f in found {
            if !expected.contains(&f) {
                errs.push(format!("orphan (not in registry): {}", f.display()));
            }
        }
    }
    assert!(errs.is_empty(), "{}", errs.join("\n"));
}

// ---------- Tier 2: semantic (requires prlg) ----------

fn prlg_exit(file: &Path, goal: &str) -> i32 {
    let output = Command::new("prlg")
        .args(["run"])
        .arg(file)
        .args(["--goal", goal, "--format", "text"])
        .output()
        .expect("failed to invoke `prlg` — it is required to run the curriculum tests");
    output.status.code().unwrap_or(-1)
}

fn require_prlg() {
    let ok = Command::new("prlg")
        .arg("--version")
        .output()
        .map(|o| o.status.success())
        .unwrap_or(false);
    assert!(
        ok,
        "`prlg` not found on PATH — it is required for the semantic curriculum \
         tests. CI installs a pinned `patch-prolog`; for local dev, install it."
    );
}

#[test]
fn every_solution_passes_its_test() {
    require_prlg();
    let mut errs = Vec::new();
    for e in &registry() {
        let goal = if e.mode == "parse" { "true" } else { "test" };
        let code = prlg_exit(&solution_path(&e.path), goal);
        // exit 1 == goal succeeded (the pass contract from runner.rs).
        if code != 1 {
            errs.push(format!(
                "{}: solution did not pass (prlg exit {})",
                e.name, code
            ));
        }
    }
    assert!(errs.is_empty(), "failing solutions:\n{}", errs.join("\n"));
}

#[test]
fn every_starter_parses() {
    require_prlg();
    let mut errs = Vec::new();
    for e in &registry() {
        // exit 2 == parse error. A starter must always be syntactically valid.
        let code = prlg_exit(&root().join(&e.path), "true");
        if code == 2 {
            errs.push(format!("{}: starter has a parse error", e.name));
        }
    }
    assert!(
        errs.is_empty(),
        "starters with parse errors:\n{}",
        errs.join("\n")
    );
}
