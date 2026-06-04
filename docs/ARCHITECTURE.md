# Architecture

## Context & Scope

loglings is a terminal CLI that teaches Prolog through small, incrementally
harder exercises (rustlings/seqlings-style). The learner edits `.pl` files in
their own editor; loglings watches the files and re-checks on save.

Boundary: loglings does **not** interpret Prolog itself. The one external
system is the **`plgc`** compiler (from the `patch-prolog2` sibling project,
crate `plg-compiler`; must be on `PATH`), invoked as a subprocess to check each
exercise. `plgc` is a real LLVM-based compiler — it compiles each file to a
native binary and runs it (it never interprets), so **`clang` ≥ 15** must be on
`PATH` too. loglings is the downstream consumer and feeds findings back as
issues. (It previously used `patch-prolog`'s `prlg` engine, now archived in
favor of this compiler.) Everything else — exercises,
hints, solutions — ships inside the loglings binary.

## Solution Strategy

- **Rust binary**, CLI via `clap`.
- **Self-contained corpus.** `exercises/`, `solutions/`, and `hints/` are baked
  into the binary at build time with `include_dir!`. `loglings init` extracts
  them into a fresh workspace; the published crate needs no repo checkout.
- **Checking is delegated**, not embedded: `runner` shells out to
  `plgc run <file> --query <goal> --format text` and maps the compiler's
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
- `src/runner.rs` — the `plgc` subprocess seam and exit-code mapping.
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
- **Exit-code contract** is the entire integration with the `plgc` compiler;
  its stdout/stderr is surfaced to the learner verbatim (so compiler
  error-message quality matters).
- **Compiler behavior shapes exercise authoring.** Learner-supplied *fact*
  predicates get a `:- dynamic(F/A).` declaration in the hidden section so an
  un-started file fails as `false.` instead of throwing `existence_error`.
  The language is an ISO subset — no `op/3`, no postfix operators — which the
  `03-operators` chapter teaches as a deliberate boundary.
- **The corpus is the test surface.** `tests/curriculum.rs` is where loglings is
  actually tested: structural checks over `info.toml` and the three trees, plus
  semantic checks that compile every reference solution and starter with `plgc`.
  CI (`just ci` on the `navicore-rust` Forgejo runner, which provides `clang`)
  provisions `plgc` first so the semantic tests can compile.
