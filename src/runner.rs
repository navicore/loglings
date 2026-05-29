//! Shells out to `patch-prolog run` to check an exercise file.
//!
//! Exit-code contract (from patch-prolog run):
//!   0 = goal produced no solutions (test failed)
//!   1 = goal produced ≥1 solution (test passed)
//!   2 = parse error
//!   3 = runtime error (uncaught throw, step limit, etc.)

use std::path::Path;
use std::process::Command;

const PATCH_PROLOG: &str = "patch-prolog";

#[derive(Debug)]
pub enum CheckOutcome {
    /// Test passed (exit 1: goal succeeded).
    Passed,
    /// Test failed (exit 0: goal had no solutions). `stderr` captured for display.
    Failed(String),
    /// Parse error in the exercise file (exit 2). String is patch-prolog's error JSON/text.
    ParseError(String),
    /// Runtime error from the engine (exit 3).
    RuntimeError(String),
    /// patch-prolog itself failed to invoke (binary missing, etc.).
    InvocationError(String),
}

/// Run `goal` against the exercise file. For parse-only exercises, pass `"true"`
/// — it succeeds iff the file parses; otherwise patch-prolog exits with code 2.
/// For test-mode exercises, the hidden checker section should define `test/0`
/// and the goal is `"test"`.
pub fn check(file: &Path, goal: &str) -> CheckOutcome {
    let output = Command::new(PATCH_PROLOG)
        .arg("run")
        .arg(file)
        .arg("--goal")
        .arg(goal)
        .arg("--format")
        .arg("text")
        .output();

    let output = match output {
        Ok(o) => o,
        Err(e) => {
            return CheckOutcome::InvocationError(format!(
                "Failed to run `{PATCH_PROLOG}`: {e}. Is patch-prolog installed and on your PATH?"
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
            "Unexpected patch-prolog exit code {other:?}: {combined}"
        )),
    }
}
