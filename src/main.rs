//! loglings — interactive exercises for learning Prolog.

#![warn(clippy::pedantic)]
// Two pedantic lints misfire on this codebase: `needless_continue` flags the
// explicit `Timeout => continue` in the watch poll loop (clearer as written),
// and `case_sensitive_file_extension_comparisons` wants a case-insensitive
// `.pl` check, but our corpus paths are always lowercase by construction.
#![allow(
    clippy::needless_continue,
    clippy::case_sensitive_file_extension_comparisons
)]

mod exercise;
mod runner;
mod update;

use clap::{Parser, Subcommand};
use colored::Colorize;
use exercise::{Exercise, Status};
use include_dir::{Dir, include_dir};
use notify_debouncer_mini::{DebounceEventResult, new_debouncer};
use std::path::{Path, PathBuf};
use std::sync::mpsc::channel;
use std::time::Duration;

static EXERCISES_DIR: Dir = include_dir!("$CARGO_MANIFEST_DIR/exercises");
static SOLUTIONS_DIR: Dir = include_dir!("$CARGO_MANIFEST_DIR/solutions");
static HINTS_DIR: Dir = include_dir!("$CARGO_MANIFEST_DIR/hints");

#[derive(Parser)]
#[command(name = "loglings", about = "Interactive Prolog exercises", version)]
struct Cli {
    #[command(subcommand)]
    command: Option<Command>,
}

#[derive(Subcommand)]
enum Command {
    /// Create a new loglings project directory with exercises, hints, and solutions
    Init {
        /// Where to create the project (defaults to "my-loglings")
        #[arg(default_value = "my-loglings")]
        path: PathBuf,
    },
    /// Refresh untouched exercises from the binary. Files you've started
    /// (the `% I AM NOT DONE` marker is gone) are preserved by default; pass
    /// `--force <name>` per file to override. Hints and solutions always
    /// refresh wholesale.
    Update {
        /// Show what would happen without writing anything
        #[arg(long)]
        dry_run: bool,
        /// Force-replace a specific exercise even if you've touched it. Pass
        /// the path under exercises/ — e.g. `00-intro/01-fact` (with or
        /// without `.pl`). Repeatable.
        #[arg(long, value_name = "EXERCISE")]
        force: Vec<String>,
    },
    /// Show every exercise with its status
    List,
    /// Check every exercise once
    Verify,
    /// Print the hint for the current (or named) exercise
    Hint { name: Option<String> },
    /// Mark the current exercise done and move on
    Next,
    /// Restore an exercise (or all of them) to its original embedded contents
    Reset { name: Option<String> },
}

fn main() {
    let cli = Cli::parse();

    // `init` doesn't need an existing workspace. `update` does — it edits
    // files in the cwd's `exercises/`, so we want the "no workspace here"
    // hint if the user is in the wrong place.
    match cli.command {
        Some(Command::Init { path }) => {
            cmd_init(&path);
            return;
        }
        Some(Command::Update { dry_run, force }) => {
            ensure_workspace();
            update::run(dry_run, &force, &EXERCISES_DIR, &SOLUTIONS_DIR, &HINTS_DIR);
            return;
        }
        _ => {}
    }

    let base = std::env::current_dir().expect("cwd");
    let exercises = load_exercises_from_cwd(&base);

    match cli.command {
        Some(Command::Init { .. } | Command::Update { .. }) => {
            unreachable!("handled above")
        }
        None => watch(&exercises),
        Some(Command::List) => list(&exercises),
        Some(Command::Verify) => verify(&exercises),
        Some(Command::Hint { name }) => hint(&exercises, name.as_deref()),
        Some(Command::Next) => next(&exercises),
        Some(Command::Reset { name }) => reset(&exercises, &base, name.as_deref()),
    }
}

/// Fail fast with the same "run `loglings init`" hint that other commands
/// give, when the cwd isn't a workspace. Update doesn't need the parsed
/// exercise list — it walks the embedded tree — but it shouldn't run from
/// a random directory.
fn ensure_workspace() {
    let info = std::env::current_dir()
        .unwrap_or_default()
        .join("exercises")
        .join("info.toml");
    if !info.exists() {
        eprintln!(
            "{} No loglings workspace here (no {}).",
            "Error:".red(),
            info.display()
        );
        eprintln!(
            "{} Run `{}` to create one, then `cd` into it.",
            "Hint:".yellow(),
            "loglings init".cyan()
        );
        std::process::exit(1);
    }
}

/// Read `exercises/info.toml` from the user's cwd. If it's missing, fail
/// with a clear hint pointing at `loglings init`.
fn load_exercises_from_cwd(base: &Path) -> Vec<Exercise> {
    let info_path = base.join("exercises").join("info.toml");
    let Ok(info_toml) = std::fs::read_to_string(&info_path) else {
        eprintln!(
            "{} No loglings workspace here (couldn't read {}).",
            "Error:".red(),
            info_path.display()
        );
        eprintln!(
            "{} Run `{}` to create one, then `cd` into it.",
            "Hint:".yellow(),
            "loglings init".cyan()
        );
        std::process::exit(1);
    };
    exercise::load(&info_toml, base).unwrap_or_else(|e| {
        eprintln!("{} {e}", "Failed to load exercises:".red());
        std::process::exit(1);
    })
}

/// Extract the embedded exercises/solutions/hints into a fresh directory.
fn cmd_init(path: &Path) {
    if path.exists() {
        eprintln!(
            "{} `{}` already exists. Choose a different name or remove it first.",
            "Error:".red(),
            path.display()
        );
        std::process::exit(1);
    }
    println!(
        "{} Creating loglings workspace at {}",
        "→".cyan(),
        path.display()
    );
    if let Err(e) = std::fs::create_dir_all(path) {
        eprintln!(
            "{} Could not create {}: {e}",
            "Error:".red(),
            path.display()
        );
        std::process::exit(1);
    }
    for (name, dir) in [
        ("exercises", &EXERCISES_DIR),
        ("solutions", &SOLUTIONS_DIR),
        ("hints", &HINTS_DIR),
    ] {
        let sub = path.join(name);
        if let Err(e) = std::fs::create_dir_all(&sub) {
            eprintln!("{} Could not create {}: {e}", "Error:".red(), sub.display());
            std::process::exit(1);
        }
        if let Err(e) = dir.extract(&sub) {
            eprintln!("{} Failed to write {name}/: {e}", "Error:".red());
            std::process::exit(1);
        }
        println!("  {} {name}/", "✓".green());
    }
    println!("\n{} Workspace ready.", "✓".green().bold());
    println!("Next:");
    println!("  {} {}", "cd".cyan(), path.display());
    println!("  {}", "loglings".cyan());
}

fn list(exercises: &[Exercise]) {
    for ex in exercises {
        let tag = match ex.status() {
            Status::Done => "  done   ".green(),
            Status::NotDone => " pending ".yellow(),
            Status::Failed(_) => " failing ".red(),
        };
        println!("[{tag}] {}", ex.name);
    }
}

fn verify(exercises: &[Exercise]) {
    let mut done = 0;
    let mut not_done = 0;
    let mut failing = 0;
    for ex in exercises {
        match ex.status() {
            Status::Done => done += 1,
            Status::NotDone => not_done += 1,
            Status::Failed(_) => failing += 1,
        }
    }
    println!(
        "{} done, {} pending, {} failing",
        done.to_string().green(),
        not_done.to_string().yellow(),
        failing.to_string().red(),
    );
    if failing > 0 || not_done > 0 {
        std::process::exit(1);
    }
}

fn current(exercises: &[Exercise]) -> Option<&Exercise> {
    exercises
        .iter()
        .find(|e| !matches!(e.status(), Status::Done))
}

fn hint(exercises: &[Exercise], name: Option<&str>) {
    let ex = match name {
        Some(n) => exercises.iter().find(|e| e.name == n),
        None => current(exercises),
    };
    let Some(ex) = ex else {
        println!("{}", "Nothing to hint — all exercises pass.".green());
        return;
    };
    // ex.path is absolute (base.join(...)). Walk it back to the relative
    // shape that HINTS_DIR expects (e.g., "00-intro/01-fact.md").
    let base = std::env::current_dir().unwrap_or_default();
    let rel = ex.path.strip_prefix(&base).unwrap_or(&ex.path);
    let rel = rel.strip_prefix("exercises").unwrap_or(rel);
    let rel_md = PathBuf::from(rel).with_extension("md");
    let hint = HINTS_DIR.get_file(&rel_md).and_then(|f| f.contents_utf8());
    match hint {
        Some(text) => println!("{text}"),
        None => println!("(no hint for {})", ex.name),
    }
}

fn next(exercises: &[Exercise]) {
    let Some(ex) = current(exercises) else {
        println!("{}", "All exercises pass — no current exercise.".green());
        return;
    };
    let content = std::fs::read_to_string(&ex.path).unwrap_or_default();
    let cleaned = content
        .lines()
        .filter(|l| l.trim() != exercise::NOT_DONE_MARKER.trim())
        .collect::<Vec<_>>()
        .join("\n");
    if let Err(e) = std::fs::write(&ex.path, cleaned) {
        eprintln!("{} {e}", "Failed to update file:".red());
        std::process::exit(1);
    }
    println!("Skipped {}.", ex.name.yellow());
}

fn reset(exercises: &[Exercise], base: &Path, name: Option<&str>) {
    let targets: Vec<&Exercise> = match name {
        Some(n) => exercises.iter().filter(|e| e.name == n).collect(),
        None => current(exercises).into_iter().collect(),
    };
    if targets.is_empty() {
        eprintln!("{}", "No exercise to reset.".red());
        std::process::exit(1);
    }
    for ex in targets {
        let rel = ex.path.strip_prefix(base).unwrap_or(&ex.path);
        let rel = rel.strip_prefix("exercises").unwrap_or(rel);
        let Some(file) = EXERCISES_DIR.get_file(rel) else {
            eprintln!("{} {}", "No embedded source for".red(), ex.name);
            continue;
        };
        let bytes = file.contents();
        if let Err(e) = std::fs::write(&ex.path, bytes) {
            eprintln!("{} {e}", "Failed to write:".red());
            continue;
        }
        println!("Reset {}.", ex.name.green());
    }
}

fn watch(exercises: &[Exercise]) {
    println!(
        "{}",
        "Watching exercises/. Save a file to re-check. Ctrl-C to quit.".dimmed()
    );

    let (tx, rx) = channel::<DebounceEventResult>();
    let mut debouncer = new_debouncer(Duration::from_millis(200), tx).expect("debouncer");
    debouncer
        .watcher()
        .watch(
            &PathBuf::from("exercises"),
            notify::RecursiveMode::Recursive,
        )
        .expect("watch exercises/");

    let interrupted = std::sync::Arc::new(std::sync::atomic::AtomicBool::new(false));
    let int_for_handler = interrupted.clone();
    ctrlc::set_handler(move || {
        int_for_handler.store(true, std::sync::atomic::Ordering::SeqCst);
    })
    .expect("install ctrl-c handler");

    // Track what we last showed the user so we don't re-print on every save.
    // `last_name == None` means we haven't shown anything yet (force first
    // render); `last_name == Some("")` is the sentinel for "all done."
    let mut last_name: Option<String> = None;
    let mut last_status: Option<Status> = None;
    refresh(exercises, &mut last_name, &mut last_status);

    while !interrupted.load(std::sync::atomic::Ordering::SeqCst) {
        match rx.recv_timeout(Duration::from_millis(250)) {
            Ok(Ok(_events)) => refresh(exercises, &mut last_name, &mut last_status),
            Ok(Err(error)) => eprintln!("watcher: {error:?}"),
            Err(std::sync::mpsc::RecvTimeoutError::Timeout) => continue,
            Err(std::sync::mpsc::RecvTimeoutError::Disconnected) => break,
        }
    }
}

/// Render the watch frame only if something actually changed. Announces the
/// previous exercise as `✓ passed` when we cross from it to the next one.
fn refresh(
    exercises: &[Exercise],
    last_name: &mut Option<String>,
    last_status: &mut Option<Status>,
) {
    let Some(ex) = current(exercises) else {
        if last_name.as_deref() != Some("") {
            if let Some(prev) = last_name.as_deref()
                && !prev.is_empty()
            {
                println!("  {} {}", "✓".green(), prev.cyan());
            }
            println!("\n{}", "All exercises pass — you're done!".green().bold());
            *last_name = Some(String::new());
            *last_status = None;
        }
        return;
    };

    let status = ex.status();
    let same_name = last_name.as_deref() == Some(ex.name.as_str());
    let same_status = last_status.as_ref() == Some(&status);
    if same_name && same_status {
        return;
    }

    // We moved past the previous exercise (it transitioned to Done).
    if let Some(prev) = last_name.as_deref()
        && !prev.is_empty()
        && prev != ex.name
    {
        println!("  {} {}", "✓".green(), prev.cyan());
    }

    report(ex, &status);
    *last_name = Some(ex.name.clone());
    *last_status = Some(status);
}

fn report(ex: &Exercise, status: &Status) {
    println!();
    match status {
        // Watch never reports Done — `current()` skips Done exercises, and the
        // "all done" branch is handled inline in `refresh`.
        Status::Done => {}
        Status::NotDone => {
            println!("{} {}", "→".cyan().bold(), ex.name.cyan().bold());
            println!("  open {} and finish the exercise.", ex.path.display());
            println!("  remove the `% I AM NOT DONE` line when you think it's ready.");
            println!(
                "  ({} for a hint)",
                format!("loglings hint {}", ex.name).dimmed()
            );
        }
        Status::Failed(msg) => {
            println!("{} {}", "✗".red().bold(), ex.name.cyan().bold());
            for line in msg.lines() {
                println!("  {line}");
            }
        }
    }
}
