# Roadmap

## Current state

Engine: `patch-prolog` (subprocess). CLI commands implemented: `init`,
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

## Known issues / external dependencies

- Surfaced to patch-prolog: #18 (parse-error line numbers offset by prepended
  stdlib), #19 (operators rejected as bare atoms — must be quoted), #20 (errors
  name internal token types), #21 (no stdin / inline `--program` input). #18 and
  #20 directly affect the learner's error experience, since loglings shows
  engine output verbatim.
- `README.md` curriculum table is stale — it lists only `00-intro`.

## Future

More sections, tracking new patch-prolog engine capabilities (e.g. `assert`/
`retract`, DCGs) as they land.
