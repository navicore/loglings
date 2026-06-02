# Architecture

## Context & Scope

loglings is a terminal CLI that teaches Prolog through small, incrementally
harder exercises (rustlings/seqlings-style). The learner edits `.pl` files in
their own editor; loglings watches the files and re-checks on save.

Boundary: loglings does **not** interpret Prolog itself. The one external
system is **`patch-prolog`** (a sibling project, must be on `PATH`), invoked as
a subprocess to check each exercise. loglings is the downstream consumer of
that engine and also feeds findings back to it as issues (e.g. patch-prolog
#18–#21). Everything else — exercises, hints, solutions — ships inside the
loglings binary.

## Solution Strategy

- **Rust binary**, CLI via `clap`.
- **Self-contained corpus.** `exercises/`, `solutions/`, and `hints/` are baked
  into the binary at build time with `include_dir!`. `loglings init` extracts
  them into a fresh workspace; the published crate needs no repo checkout.
- **Checking is delegated**, not embedded: `runner` shells out to
  `patch-prolog run <file> --goal <goal> --format text` and maps the engine's
  exit-code contract (`0` no solutions / `1` solutions / `2` parse error /
  `3` runtime error) onto a `CheckOutcome`.
- **Watch loop** via `notify` + a 200 ms debouncer; re-renders only when the
  current exercise or its status actually changes.

## Building Blocks

- `src/main.rs` — CLI subcommands (`init`, `update`, `list`, `verify`, `hint`,
  `next`, `reset`; default = watch). Owns the three embedded `Dir`s and the
  watch/render loop.
- `src/exercise.rs` — domain model. `Exercise { name, path, mode }`, `Status`
  (`NotDone` / `Done` / `Failed(msg)`), `ExerciseMode` (`Parse` / `Test`).
  `load()` parses `exercises/info.toml`; `status()` reads the on-disk file,
  checks for the marker, else calls `runner::check`.
- `src/runner.rs` — the patch-prolog subprocess seam and exit-code mapping.
- `src/update.rs` — refreshes on-disk exercises from the embedded corpus
  without trampling in-progress work (`Create` / `Replace` / `ForceReplace` /
  `Preserve` / `AlreadyCurrent`).
- `exercises/info.toml` — the registry/manifest: an ordered list of
  `{ name, path, mode }`. **Source of curriculum order and identity.**
- `exercises/`, `hints/`, `solutions/` — three parallel trees, mirrored by
  relative path.

### Invariants

- **`info.toml` order is the curriculum order.** Exercise `name` must be unique
  — `hint`/`reset` look an exercise up by `name`. Names are *not*
  chapter-prefixed, so they survive directory renames.
- **The three trees mirror each other by relative path.** A hint is found by
  taking the exercise's path, stripping `exercises/`, and swapping `.pl`→`.md`
  under `hints/`; `reset` restores the embedded exercise bytes. Renaming a
  chapter directory therefore means moving it in all three trees **and**
  updating `path=` in `info.toml`.
- **The `% I AM NOT DONE` marker gates `NotDone`.** Matched as a whole trimmed
  line (never a substring), so instructional prose may quote it.
- **Hidden checker.** Everything below `% Do not edit below this line` belongs
  to loglings: `mode = "test"` exercises define `test/0` (the checker goal);
  `mode = "parse"` exercises only need to parse.

## Crosscutting Concepts

- **Embedded corpus vs working copy.** `include_dir!` holds the canonical bytes;
  the workspace on disk is the editable copy; `reset`/`update` reconcile them.
- **Exit-code contract** is the entire integration with patch-prolog; engine
  stdout/stderr is surfaced to the learner verbatim (so engine error-message
  quality matters — cf. patch-prolog #18/#20).
- **Engine constraints shape exercise authoring.** Operators must be written as
  quoted atoms in term position (patch-prolog #19); learner-supplied *fact*
  predicates get a `:- dynamic(F/A).` declaration in the hidden section so an
  un-started file fails as `false.` instead of throwing `existence_error`.
