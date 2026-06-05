# Roadmap

## Current state

Compiler: the `plgc` binary (subprocess; from patch-prolog2, crate
`plg-compiler`, currently 0.1.0). It compiles each exercise to a native binary
via LLVM and links with `clang` ≥ 15 — so `clang` is a runtime dependency. This
replaced the now-archived `patch-prolog` / `prlg` engine; the CLI contract
(`run … --query … --format text`, exit codes `0/1/2/3`) and the ISO-subset
language (still no `op/3`/postfix) carried over, so loglings needed only the
binary name and the `--goal`→`--query` flag rename. CLI commands implemented: `init`,
`update` (+ `--dry-run`, `--force`), `list`, `verify`, `hint`, `next`, `reset`,
and the default watch loop.

Curriculum on disk (5 exercises each):

| Section | Topics |
|---|---|
| `00-intro` | facts, multiple facts, `findall/3`, rules, lists |
| `01-arithmetic` | `is/2` and the four operators |
| `02-comparison` | `<` `>` `=<` `>=` `=:=` `=\=` |
| `03-recursion` | base case + recursive step |

## In progress

Restructure to teach the term model *before* comparison (see
[`design/terms-and-operators-chapters.md`](design/terms-and-operators-chapters.md)):

- Insert **`02-terms`** (4 exercises: atoms/numbers, variables/unification,
  compound terms, arity) and **`03-operators`** (2 exercises: operators-as-terms,
  precedence/associativity).
- Renumber `02-comparison` → `04-comparison`, `03-recursion` → `05-recursion`
  (content unchanged; move all three trees + update `info.toml` paths).
- **Strip the `## Solution sketch` block from every hint** — hints are nudges;
  full answers live in `solutions/`.

All six new exercises are verified passing on the installed engine.

## External dependencies

- **Compiler: `plgc`** (patch-prolog2 / `plg-compiler`, 0.1.0) plus
  **`clang` ≥ 15**. patch-prolog2 supersedes the now-archived patch-prolog: a
  real LLVM compiler rather than an interpreter. The ISO-subset language, the
  builtin vocabulary, and the `0/1/2/3` exit-code contract carried over at
  parity, so the curriculum was unaffected — only the binary name and the
  `--goal`→`--query` flag changed.
- **No `op/3`, no postfix operators** (by design, unchanged from the old
  engine) — the `03-operators` chapter teaches this as the compiler boundary.
- The prefix/infix completeness the curriculum relies on (full prefix/infix
  incl. right-associative `^`) carried into patch-prolog2.

## Notes

- **CI provisions `plgc` via git, tracking patch-prolog2 `main`**:
  `cargo install --git …/patch-prolog2.git --branch main plg-compiler --locked`.
  crates.io publishing is deliberately deferred until patch-prolog2 matures;
  when it lands, switch the workflow to `cargo install plg-compiler --version X`.

## Future

More sections, tracking new patch-prolog2 / `plgc` capabilities as they land.
