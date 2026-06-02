# Roadmap

## Current state

Engine: the `prlg` binary (subprocess; from the patch-prolog project),
currently 0.4.1. CLI commands implemented: `init`,
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

- All five engine findings (patch-prolog #17–#21) are **resolved as of
  `prlg` 0.4.1**: correct parse-error line numbers, operators usable as bare
  atoms, surface-syntax error messages, and stdin / inline `--program` input.
  The binary was renamed `patch-prolog` → `prlg` (a breaking change; loglings'
  runner now invokes `prlg`).
- Open engine items raised for the operator lessons (none block loglings — its
  test path is in-file clauses with single-atom goals): #28 (prefix `+`/`\`),
  #29 (infix `** ^ >> << xor div /\ \/ :`), #30 (`--goal` query silently
  truncates at the first unparsed token), #31 (document operator support /
  postfix unsupported by design). The prefix/infix curriculum is built against
  what 0.4.1 already supports (`-`, `\+`, the arithmetic/comparison infix set).
- `README.md` curriculum table is stale — it lists only `00-intro`.

## Future

More sections, tracking new patch-prolog engine capabilities (e.g. `assert`/
`retract`, DCGs) as they land.
