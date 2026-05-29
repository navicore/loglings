//! `loglings update` — refresh on-disk exercises from the embedded corpus
//! without trampling the user's in-progress work.
//!
//! Rule per file (mirrors seqlings):
//! - File missing on disk → **Create**.
//! - On-disk bytes already match the embedded copy → **AlreadyCurrent** (no-op).
//! - User listed it via `--force <name>` → **ForceReplace**.
//! - The `% I AM NOT DONE` marker is still present as a whole line → user
//!   hasn't started yet → **Replace**.
//! - Otherwise the user has edited the file → **Preserve**, leave it alone.
//!
//! `hints/`, `solutions/`, and `exercises/info.toml` are reference material
//! and refresh wholesale (the user isn't expected to edit them).

use crate::exercise::NOT_DONE_MARKER;
use colored::Colorize;
use include_dir::{Dir, File};
use std::collections::HashSet;
use std::path::{Path, PathBuf};

#[derive(Debug)]
enum Action {
    Create,
    AlreadyCurrent,
    Replace,
    ForceReplace,
    Preserve,
}

pub fn run(
    dry_run: bool,
    force: &[String],
    exercises_dir: &Dir<'_>,
    solutions_dir: &Dir<'_>,
    hints_dir: &Dir<'_>,
) {
    let force_set = normalize_force(force);

    let mut embedded = Vec::new();
    collect_files(exercises_dir, &mut embedded);
    // info.toml is the manifest — always refresh, separately from the
    // per-exercise decisions.
    let exercise_files: Vec<&File<'_>> = embedded
        .into_iter()
        .filter(|f| f.path() != Path::new("info.toml"))
        .collect();

    let mut created = Vec::new();
    let mut replaced = Vec::new();
    let mut force_replaced = Vec::new();
    let mut preserved = Vec::new();
    let mut current_count = 0usize;
    let mut errors = Vec::new();

    for f in &exercise_files {
        let rel = f.path();
        let rel_str = rel.to_string_lossy().into_owned();
        let on_disk = PathBuf::from("exercises").join(rel);
        let forced = force_set.contains(&rel_str);

        match classify(&on_disk, f.contents(), forced) {
            Action::AlreadyCurrent => current_count += 1,
            Action::Create => {
                created.push(rel_str);
                if !dry_run {
                    if let Err(e) = write_file(&on_disk, f.contents()) {
                        errors.push(format!("create {}: {e}", on_disk.display()));
                    }
                }
            }
            Action::Replace => {
                replaced.push(rel_str);
                if !dry_run {
                    if let Err(e) = write_file(&on_disk, f.contents()) {
                        errors.push(format!("replace {}: {e}", on_disk.display()));
                    }
                }
            }
            Action::ForceReplace => {
                force_replaced.push(rel_str);
                if !dry_run {
                    if let Err(e) = write_file(&on_disk, f.contents()) {
                        errors.push(format!("force-replace {}: {e}", on_disk.display()));
                    }
                }
            }
            Action::Preserve => preserved.push(rel_str),
        }
    }

    if !dry_run {
        if let Some(info) = exercises_dir.get_file("info.toml") {
            if let Err(e) = write_file(Path::new("exercises/info.toml"), info.contents()) {
                errors.push(format!("refresh exercises/info.toml: {e}"));
            }
        }
        if let Err(e) = refresh_tree(solutions_dir, "solutions") {
            errors.push(format!("refresh solutions/: {e}"));
        }
        if let Err(e) = refresh_tree(hints_dir, "hints") {
            errors.push(format!("refresh hints/: {e}"));
        }
    }

    print_summary(
        &created,
        &replaced,
        &force_replaced,
        &preserved,
        current_count,
        &errors,
        dry_run,
    );

    if !errors.is_empty() {
        std::process::exit(1);
    }
}

/// Normalize each `--force` value to the relative path used inside the
/// embedded tree. Accepts forms with or without `exercises/` prefix and
/// with or without the `.pl` extension.
fn normalize_force(force: &[String]) -> HashSet<String> {
    force
        .iter()
        .map(|s| {
            let stripped = s
                .trim_start_matches("./")
                .trim_start_matches("exercises/")
                .to_string();
            if stripped.ends_with(".pl") {
                stripped
            } else {
                format!("{stripped}.pl")
            }
        })
        .collect()
}

fn classify(on_disk: &Path, embedded: &[u8], forced: bool) -> Action {
    let on_disk_bytes = match std::fs::read(on_disk) {
        Ok(b) => b,
        Err(_) => return Action::Create,
    };
    if on_disk_bytes == embedded {
        return Action::AlreadyCurrent;
    }
    if forced {
        return Action::ForceReplace;
    }
    let text = String::from_utf8_lossy(&on_disk_bytes);
    // Use a per-line check so prose mentions of the marker (e.g. in the
    // instruction comments) don't fool us into thinking the user hasn't
    // started. Consistent with `Exercise::status`.
    if text.lines().any(|l| l.trim() == NOT_DONE_MARKER) {
        Action::Replace
    } else {
        Action::Preserve
    }
}

fn collect_files<'a>(dir: &'a Dir<'a>, out: &mut Vec<&'a File<'a>>) {
    for entry in dir.entries() {
        match entry {
            include_dir::DirEntry::File(f) => out.push(f),
            include_dir::DirEntry::Dir(d) => collect_files(d, out),
        }
    }
}

fn refresh_tree(dir: &Dir<'_>, target_root: &str) -> std::io::Result<()> {
    let mut files = Vec::new();
    collect_files(dir, &mut files);
    for f in files {
        let target = PathBuf::from(target_root).join(f.path());
        if let Some(parent) = target.parent() {
            std::fs::create_dir_all(parent)?;
        }
        std::fs::write(&target, f.contents())?;
    }
    Ok(())
}

fn write_file(path: &Path, bytes: &[u8]) -> std::io::Result<()> {
    if let Some(parent) = path.parent() {
        std::fs::create_dir_all(parent)?;
    }
    std::fs::write(path, bytes)
}

#[allow(clippy::too_many_arguments)]
fn print_summary(
    created: &[String],
    replaced: &[String],
    force_replaced: &[String],
    preserved: &[String],
    current_count: usize,
    errors: &[String],
    dry_run: bool,
) {
    if dry_run {
        println!("\n{}", "[dry run] no files were modified".yellow().bold());
    }

    if !created.is_empty() {
        println!(
            "\n{}",
            format!("Created ({}):", created.len()).green().bold()
        );
        for n in created {
            println!("  {} {}", "+".green(), n);
        }
    }
    if !replaced.is_empty() {
        println!(
            "\n{}",
            format!("Replaced ({}):", replaced.len()).cyan().bold()
        );
        for n in replaced {
            println!("  {} {}", "~".cyan(), n);
        }
    }
    if !force_replaced.is_empty() {
        println!(
            "\n{}",
            format!("Force-replaced ({}):", force_replaced.len())
                .yellow()
                .bold()
        );
        for n in force_replaced {
            println!("  {} {}", "!".yellow(), n);
        }
    }
    if !preserved.is_empty() {
        println!(
            "\n{}",
            format!(
                "Preserved ({}, your work was kept; pass --force <path> to override):",
                preserved.len()
            )
            .bold()
        );
        for n in preserved {
            println!("  {} {}", "-".dimmed(), n.dimmed());
        }
    }

    println!(
        "\n{} already up to date · {} created · {} replaced · {} force-replaced · {} preserved",
        current_count,
        created.len(),
        replaced.len(),
        force_replaced.len(),
        preserved.len()
    );

    if !errors.is_empty() {
        eprintln!("\n{}", "Errors:".red().bold());
        for e in errors {
            eprintln!("  {} {}", "✗".red(), e);
        }
    }
}
