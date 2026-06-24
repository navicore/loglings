//! Exercise loading and status checking.
//!
//! Exercises are embedded at build time via `include_dir!`. At runtime the
//! file on disk under `exercises/` is what the user edits and what the checker
//! sees; the embedded copy is reference material for `reset`.

use crate::runner::{self, CheckOutcome};
use serde::Deserialize;
use std::path::PathBuf;

pub const NOT_DONE_MARKER: &str = "% I AM NOT DONE";

/// How loglings decides whether an exercise passes.
#[derive(Debug, Clone, Copy, Default, Deserialize, PartialEq, Eq)]
#[serde(rename_all = "lowercase")]
pub enum ExerciseMode {
    /// File must parse (the engine returns exit code != 2 on `--query "true"`).
    Parse,
    /// Hidden checker section defines `test/0` and that goal must succeed.
    #[default]
    Test,
}

/// Status of an exercise at a moment in time.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Status {
    /// `% I AM NOT DONE` marker still present.
    NotDone,
    /// Marker removed and the check passes.
    Done,
    /// Marker removed but check failed. String is the diagnostic.
    Failed(String),
}

/// Registry entry from `exercises/info.toml`.
#[derive(Debug, Clone, Deserialize)]
pub struct ExerciseInfo {
    pub name: String,
    pub path: String,
    #[serde(default)]
    pub mode: ExerciseMode,
}

#[derive(Debug, Deserialize)]
struct InfoFile {
    exercises: Vec<ExerciseInfo>,
}

/// A loaded exercise with its on-disk path resolved.
#[derive(Debug, Clone)]
pub struct Exercise {
    pub name: String,
    pub path: PathBuf,
    pub mode: ExerciseMode,
}

impl Exercise {
    pub fn status(&self) -> Status {
        let content = match std::fs::read_to_string(&self.path) {
            Ok(c) => c,
            Err(e) => return Status::Failed(format!("Can't read {}: {e}", self.path.display())),
        };
        // Match the marker as a whole line, not a substring — exercise prose
        // sometimes references the marker text inline (e.g. "delete the
        // `% I AM NOT DONE` line below"), and we don't want that to count.
        if content.lines().any(|l| l.trim() == NOT_DONE_MARKER) {
            return Status::NotDone;
        }
        let goal = match self.mode {
            ExerciseMode::Parse => "true",
            ExerciseMode::Test => "test",
        };
        match runner::check(&self.path, goal) {
            CheckOutcome::Passed => Status::Done,
            CheckOutcome::Failed(msg) => {
                // For test-mode failures, try to blame the first failing check
                // in the `test/0` conjunction; fall back to the raw message.
                let blame = match self.mode {
                    ExerciseMode::Test => runner::bisect_failure(&self.path, &content),
                    ExerciseMode::Parse => None,
                };
                match blame {
                    Some(b) => Status::Failed(format!(
                        "Test failed at check {}/{} (line {}):\n    {}",
                        b.index, b.total, b.line, b.goal
                    )),
                    None => Status::Failed(format!("Test failed:\n{msg}")),
                }
            }
            CheckOutcome::ParseError(msg) => Status::Failed(format!("Parse error:\n{msg}")),
            CheckOutcome::RuntimeError(msg) => Status::Failed(format!("Runtime error:\n{msg}")),
            CheckOutcome::InvocationError(msg) => Status::Failed(msg),
        }
    }
}

/// Parse `info.toml` content and resolve each exercise's path relative to
/// `base_dir` (the project root containing `exercises/`).
pub fn load(info_toml: &str, base_dir: &std::path::Path) -> Result<Vec<Exercise>, String> {
    let info: InfoFile = toml::from_str(info_toml).map_err(|e| format!("Bad info.toml: {e}"))?;
    let mut out = Vec::with_capacity(info.exercises.len());
    for ex in info.exercises {
        out.push(Exercise {
            name: ex.name,
            path: base_dir.join(&ex.path),
            mode: ex.mode,
        });
    }
    Ok(out)
}
