//! Shells out to `plgc run` to check an exercise file. `plgc` is the Prolog
//! compiler from the `patch-prolog2` project (crate `plg-compiler`); it
//! compiles the file to a temp binary and runs it (it never interprets), so
//! `clang` must be on PATH too.
//!
//! Exit-code contract (from `plgc run`):
//!   0 = goal produced no solutions (test failed)
//!   1 = goal produced ≥1 solution (test passed)
//!   2 = parse error
//!   3 = runtime error (uncaught throw, step limit, etc.)

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
                "Failed to run `{PLGC}`: {e}. Is `{PLGC}` installed and on your PATH? (It ships with the `patch-prolog2` project; it also needs `clang`.)"
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
