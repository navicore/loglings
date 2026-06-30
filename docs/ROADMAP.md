# Roadmap

## Current state

Compiler: the `plgc` binary (subprocess; from navicore/patch-prolog, crate
`plg-compiler`). It compiles each exercise to a native binary via LLVM and
links with `clang` ≥ 15 — so `clang` is a runtime dependency. The CLI contract
is `run … --query … --format text` with exit codes `0/1/2/3`, over an
ISO-subset language (no `op/3`/postfix). CLI commands implemented: `init`,
`update` (+ `--dry-run`, `--force`), `list`, `verify`, `hint`, `next`, `reset`,
and the default watch loop.

Curriculum on disk (84 exercises):

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
| `08-control` (7) | disjunction `;`, if-then-else `-> ;`, `true`/`fail` (the two built-in zero-arity goals — an atom is a goal), the solution-count trio `\+`/`once/1`/`findall/3`, traffic capstone |
| `09-cut` (5) | the cut `!`, commit-or-default (green vs load-bearing), the cut-fail idiom, transparency in `;` |
| `10-list-library` (6) | `member/2`, `append/3` (join & split), `reverse/2`, `length/2`, `last/2`, `between/3` |
| `11-meta` (4) | higher-order predicates with `call/N` (forall, filter, map), `=..` dispatch capstone |
| `12-types` (4) | type-test guards: `var`/`nonvar` (instantiation), `number`/`integer`/`float` (safe arithmetic), `atom`/`compound`/`is_list` (shape dispatch) |
| `13-arith-depth` (5) | division family (`//` `mod` `rem` `div`), powers (`^` int vs `**` float), bitwise flags (`<<` `>>` `/\` `\|/` `xor`), relational `succ/2`/`plus/3` |
| `14-atoms-text` (6) | `atom_length/2`, `atom_concat/3` (join & relational split), `atom_chars/2` (atom↔list, both ways), `number_chars/2` (compare digits as atoms) vs `number_codes/2` (compute on digits as codes) |
| `15-exceptions` (5) | `catch/3` & `throw/1`; the ISO `error(Formal, Context)` taxonomy (catch an engine error); selective catching & rethrow (the catcher is a unification); `throw` as non-local exit; typed errors as a reporting channel |
| `16-boundaries` (5) | the engine's edges: catchable `int_overflow` (64-bit integers, no wraparound/bignum); the **uncatchable** `resource_error(steps)` (termination is a correctness duty); no dynamic database (`assertz`→`existence_error`, use accumulators); the fixed operator table (`op/3`/postfix/DCG are parse errors; operators are just compounds); robust-evaluator capstone |

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

- **Compiler: `plgc`** (navicore/patch-prolog / `plg-compiler`) plus
  **`clang` ≥ 15**. `plgc` is a real LLVM compiler, not an interpreter: it
  compiles each exercise to a native binary and runs it. The curriculum
  targets its ISO-subset language, builtin vocabulary, and `0/1/2/3`
  exit-code contract.
- **No `op/3`, no postfix operators** (by design) — the `03-operators`
  chapter teaches this as the compiler boundary.
- The curriculum relies on full prefix/infix operator support, including
  right-associative `^`.

## Notes

- CI installs `plgc` from navicore/patch-prolog `main` (trunk-based; not yet on
  crates.io).

## Future

More sections, tracking new `plgc` capabilities as they land.
