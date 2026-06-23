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
| **cut** | `!` (green/red, ISO transparency in `;`/`->`) | **09** ✓ |
| **list library** | `append/3 member/2 reverse/2 length/2 last/2 between/3` | **10** ✓ |
| **meta & term construction** | `functor/3 arg/3 =../2 copy_term/2 call/N` | **11** ✓ |
| **type-test guards** | `var nonvar atom number integer float compound is_list` | **12** ✓ |
| **arithmetic depth** | `/ // mod rem div ** ^ << >> /\ \/ xor \ succ/2 plus/3` | **13** ✓ |
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
  with a test. **08** also carries a student-authored `findall/3` rung
  (`05-collect`): `findall` is introduced at `00-03` but then only ever
  appears as hidden `test/0` scaffolding until it becomes load-bearing in
  the learner's own code at `10-06`. The rung closes that
  introduced-then-dormant seam and frames `findall` as the "all" of the
  chapter's none/one/all solution-count family (`\+` / `once` / `findall`).
- **10** teaches the library learners hand-rolled in 06, *plus* `append/3`'s
  relational multi-mode power (one predicate, many modes) — the "aha" that
  separates Prolog from functional recursion.
- **11** teaches **higher-order predicates** — the actual reason `call/N`
  and `=..` exist. A first pass framed them as thin wrappers (`relate(P,A,B)
  :- call(P,A,B).`) whose head args pass straight into the builtin; a learner
  rightly found that artificial — the mechanism was shown with no job to do.
  Reworked so the meta-call is *load-bearing*: `all_pass` (forall), `keep`
  (filter / `include`), `apply_each` (map / `maplist`) — one rule that works
  for any predicate you hand it, impossible to write without `call` — then a
  `=..`-dispatch capstone framed against the one-clause-per-name table it
  replaces. Each exercise's prose shows the *without-it* version so the
  payoff is concrete. **Deferred from 11:** (a) `copy_term/2` — its genuine
  uses (meta-interpreters, term rewriting) are beyond this point in the
  curriculum, so it's held for a later, motivated home rather than taught via
  a contrived template-reuse task; (b) `functor/3` in *construct* mode
  (`functor(T, f, 2)`) is broken on `plgc` — it shares one variable
  across all argument slots (`functor(T, point, 2)` yields `point(_6, _6)`,
  not `point(_A, _B)`), so `T = point(3, 4)` then fails. `functor/3` stays
  covered in decompose mode (ch. 02); term *construction* is covered by `=..`.
  Both are candidate demonstrations for the **16-engine-boundaries** chapter.
- **12** is built as a *guard → dispatch* arc rather than eight isolated
  yes/no demos (which would be the mechanism-only trap ch. 11 fell into).
  Each test earns a job: `var`/`nonvar` answer "have I been given a value
  yet?" — a question unification *can't* ask, because `=` with an unbound
  var always succeeds and binds (`coalesce/3`, the or-else pattern);
  `number/1` guards `is/2`, which on `plgc` doesn't fail but *crashes* the
  query (`error(type_error(evaluable, foo))`, exit 3) — so the guard makes a
  fussy op total over mixed data (`sum_nums/2`); `integer`/`float` split a
  numeric list by subtype, since `number/1` lumps `3` and `3.0` together
  (`split_num/3`). The capstone (`kind/2`) is the real lesson: the shape
  tests *overlap* (every proper list is also `compound`; `[]` is both `atom`
  and `is_list`), so classification isn't a partition — you impose one by
  *ordering* an if-then-else chain (`atom` before `is_list` to catch `[]`;
  `is_list` before `compound` to catch real lists). All eight builtins land
  in a solution, satisfying the coverage check.
- **13** gives each operator a *job* rather than a "compute this" demo:
  `digit_sum` (`//`/`mod` as a digit machine), `clock` (the `mod`-vs-`rem`
  sign split — `mod` follows the divisor so `mod 12` stays in 0..11 for
  backward deltas; `div` is its floored partner), `int_pow` (`^` int vs `**`
  float — a callback to ch. 12, sharpened by a confirmed `plgc` `write/1`
  bug: a whole-valued float is printed WITHOUT its `.0`, so `2 ** 10` shows
  `1024` even though it really is the float `1024.0` (`float/1` succeeds,
  `integer/1` rejects it, `1024.0 == 1024` is false). The *value* semantics
  are ISO-correct; only the textual output is non-compliant, and it lives in
  `write/1` itself (`write(2.0)` emits `2`), not just the CLI binding line.
  The test sidesteps it by asserting on types and `=:=`, never on printed
  digits; `/` always float, `//` always int round it out), `flags` (bitwise
  as a set: `1 << pos` masks, `\/` add, `/\ =:= mask` test, `xor` toggle,
  `>>` as the inverse shift), and `both-ways` (`succ/2`, `plus/3` as
  multi-mode RELATIONS that run backward, which `is/2` can't — a callback to
  ch. 10's `append/3`). **Deferred from 13:** unary `\` (bitwise complement)
  — `plgc` reports `type_error(evaluable, \/1)` ("Unknown arithmetic
  operator: \/1"); the binary bitwise ops all work, only the one-argument
  complement is missing.

  **Upstream `plgc` defects found while authoring (filed as patch-prolog
  issues), all boundaries-chapter (16) candidates:**
  1. *Correctness* — `functor/3` construct mode shares one variable across
     all argument slots (`functor(T, point, 2)` → `point(_, _)` with the
     same var), so building a fresh term fails. Decompose mode is fine.
  2. *Output compliance* — `write/1` drops the `.0` from whole-valued floats
     (`write(2.0)` → `2`), so a float prints indistinguishably from an
     integer and would not read back as a float. Underlying value/type is
     correct.
  3. *Incompleteness* — unary `\/1` (bitwise complement) is not an evaluable
     functor; `writeq/1` is also undefined (`existence_error`).
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
