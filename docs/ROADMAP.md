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

Curriculum on disk (54 exercises):

| Section | Topics |
|---|---|
| `00-intro` (5) | facts, multiple facts, `findall/3`, rules, lists |
| `01-arithmetic` (5) | `is/2` and the four operators |
| `02-terms` (4) | atoms, numbers, variables/unification, compound terms, arity |
| `03-operators` (3) | operators as terms, prefix/infix, precedence/associativity |
| `04-lists` (4) | destructuring: `[H\|T]`, exact shapes, `_`, heads build too |
| `05-comparison` (6) | `<` `>` `=<` `>=` `=:=` `=\=`, and choosing `is` vs `=` vs `=:=` |
| `06-recursion` (5) | base case + recursive step |
| `07-equality` (5) | `==` `\==`, standard order of terms (`@<`, `compare/3`), `sort/2` vs `msort/2` |
| `08-control` (6) | disjunction `;`, if-then-else `-> ;`, the solution-count trio `\+`/`once/1`/`findall/3`, traffic capstone |
| `09-cut` (5) | the cut `!`, commit-or-default (green vs load-bearing), the cut-fail idiom, transparency in `;` |
| `10-list-library` (6) | `member/2`, `append/3` (join & split), `reverse/2`, `length/2`, `last/2`, `between/3` |

The "term model" arc (`02-terms` → `03-operators` → `04-lists`) was added
after field feedback; design history in
[`design/terms-and-operators-chapters.md`](design/terms-and-operators-chapters.md)
and [`design/lists-chapter.md`](design/lists-chapter.md). The full coverage
plan toward exercising all of `plgc` lives in
[`design/curriculum-expansion.md`](design/curriculum-expansion.md); `05`'s
`is`/`=`/`=:=` capstone and the `07-equality` chapter (which closes the
"binds vs tests" grid with `==`) are the first steps. Hints are nudges
only; full answers live in `solutions/`.

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

- CI installs `plgc` from patch-prolog2 `main` (trunk-based; not yet on
  crates.io).

## Future

More sections, tracking new patch-prolog2 / `plgc` capabilities as they land.
