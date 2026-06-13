# Design: curriculum expansion — full plgc coverage

Status: proposed (2026-06-10). Working doc.

## Intent

The 7-chapter / 31-exercise curriculum teaches the foundations well but
exercises only about a third of `plgc`'s surface. Two goals, deliberately
held together: **(a)** a complete enough path to *learn* basic Prolog, and
**(b)** a corpus that *exercises every feature `plgc` ships* — because the
curriculum doubles as `plgc`'s real-world regression harness (ARCHITECTURE:
"the corpus is the test surface"; loglings feeds findings back as issues).
Whole pillars are currently dark: control flow, term equality/ordering, the
list library, exceptions, text predicates, arithmetic depth.

## Constraints

- **Don't disturb 00–06.** The foundation arc (intro → arithmetic → terms →
  operators → lists → comparison → recursion) is validated and well-paced;
  new chapters append after it.
- Conventions carry over unchanged: `% I AM NOT DONE` marker; hidden
  `test/0` below the fold; `:- dynamic(F/A).` for learner *fact* predicates;
  **hints nudge, never solve** (the two prose-answer spots in ch. 04/06 stay
  the documented exceptions).
- **Every exercise probe-verified against installed `plgc` before authoring**
  — the established workflow. A feature `plgc` doesn't actually support yet
  is a `plgc` issue, not an exercise.
- Out of scope: changing loglings code; the engine *exclusions* are taught
  *as boundaries*, not worked around.

## Approach

Map `plgc`'s feature roster (its `plg-shared` `BUILTINS` table + `stdlib.pl`
+ operator table) to chapters; add 9 chapters so every group lands somewhere.
Order keeps the "learn Prolog" through-line while accumulating coverage; the
boundaries chapter caps the set and directly serves the feedback mission.

| plgc feature group | builtins / constructs | where |
|---|---|---|
| facts, rules, queries, findall | — | 00 ✓ |
| basic arithmetic | `is`, `+ - * //` | 01 ✓ |
| term model | `var atom number compound functor arg =..` | 02 ✓ (partial) |
| operators & precedence | fixed op table | 03 ✓ |
| list destructuring | `[H\|T]` | 04 ✓ |
| arithmetic comparison | `< > =< >= =:= =\=` | 05 ✓ |
| recursion | base + step | 06 ✓ |
| **term equality & ordering** | `== \== @< @> @=< @>= compare/3 sort/2 msort/2` | **07** ✓ |
| **control & negation** | `; ( -> ; ) once/1 \+/1 true fail` | **08** ✓ |
| **cut** | `!` (green/red, ISO transparency in `;`/`->`) | **09** |
| **list library** | `append/3 member/2 reverse/2 length/2 last/2 between/3` | **10** |
| **meta & term construction** | `functor/3 arg/3 =../2 copy_term/2 call/N` | **11** |
| **type-test guards** | `var nonvar atom number integer float compound is_list` | **12** |
| **arithmetic depth** | `/ // mod rem div ** ^ << >> /\ \/ xor \ succ/2 plus/3` | **13** |
| **atoms & text** | `atom_length atom_concat atom_chars number_chars number_codes` | **14** |
| **exceptions** | `catch/3 throw/1` + ISO error taxonomy | **15** |
| **engine boundaries** | no `op/3`/assert/DCG/modules/postfix; overflow, ÷0, `resource_error(steps)` | **16** |

Notes on the high-value, currently-dark chapters:

- **07** resolves Prolog's classic three-way confusion the foundation sets up
  but never closes: `=` (unify) vs `==` (identity) vs `=:=` (arithmetic).
  Standard order of terms underpins `sort/2`.
- **08–09** are core Prolog and entirely absent today; cut earns its own
  chapter because `plgc` documents a specific ISO transparency semantics
  (cut in `;`/`->` cuts the whole clause — a v1 divergence) worth pinning
  with a test.
- **10** teaches the library learners hand-rolled in 06, *plus* `append/3`'s
  relational multi-mode power (one predicate, many modes) — the "aha" that
  separates Prolog from functional recursion.
- **15–16** are the feedback mission as curriculum: exceptions exercise the
  whole error taxonomy, and boundaries turns each deliberate exclusion +
  error-mode (`X is 1//0`, integer overflow, the uncatchable step limit)
  into a lesson about *this* compiler.

Sizing: ~3–5 exercises each, ~35 new, landing the curriculum near 65–70
exercises across 16 chapters. Author in coverage-priority order (07, 08, 10
first — biggest pedagogical + coverage wins), not strictly numeric.

## Domain Events

- **Chapter authored** → N exercises + solutions + nudge-hints added; the 3
  trees stay mirrored; `info.toml` extended; `just ci` must stay green
  (every solution passes, every starter parses against `plgc`).
- **A proposed exercise won't compile/pass on `plgc`** → that's a `plgc`
  capability gap or bug → file upstream (the harness working as intended),
  defer the exercise.
- **`plgc` gains/changes a builtin** → a chapter should cover it, or the
  coverage check (below) flags it. Curriculum tracks the engine.

## Checkpoints

1. `just ci` green after each chapter — full corpus compiles and passes.
2. **Coverage check**: a `tests/curriculum.rs` assertion that every
   completable name in `plgc`'s `BUILTINS` roster appears in ≥1 solution
   (roster mirrored as a plain checklist in the test — zero cross-repo
   coupling, reconciled by hand; a missing name fails the test). Turns
   "exercise all features" from aspiration into an enforced invariant.
3. Each boundaries exercise demonstrates the *expected* failure/exclusion
   (e.g. parse error on postfix, `evaluation_error` on ÷0) — verified via
   the exit-code contract, not by working around it.
4. Spot-check pacing with the user, as with the lists chapter.
