# Design: blame the failing check in a test/0 conjunction

Status: proposed (2026-06-19). Working doc.

## Intent

When a `mode = "test"` exercise fails, `plgc` reports the whole `test/0` as a
bare `false.` — the learner gets no clue *which* of the N checks failed. With
several predicates feeding one test (e.g. `08-control/06-traffic`'s `action` /
`warn` / `crossable`), that pushes people to suspect the predicate they were
last editing rather than the one actually broken. We want the watcher to say:

```
✗ 06-traffic
  Test failed at check 3 of 9 (line 43):  action(green, go)
```

— i.e. point at the first conjunct of `test/0` that has no solution.

## Constraints

- **No corpus changes.** The 54 lessons and their hidden `test/0` clauses stay
  byte-for-byte as they are. This is a *runner* feature, not a test-pattern
  change. `tests/curriculum.rs` must stay green untouched.
- **No `plgc` changes** — loglings is the downstream consumer; the exit-code
  contract (`0/1/2/3`) is the whole integration and doesn't move.
- **Pay only on failure.** Green runs must do zero extra compiles — the
  watch-loop's tight-loop guards (mtime-only change detection, current-exercise
  only) are load-bearing and must not regress.
- **Best-effort, never worse.** If blame can't be computed (test/0 isn't a
  single flat conjunction, splitting is ambiguous, the failure is a
  parse/runtime error not a clean `false.`), fall back to today's opaque
  message. No exercise should get a *wrong* blame or a crash.
- **Out of scope:** parse-mode exercises (no conjunction); multi-clause or
  helper-predicate `test/0`; reordering/“fixing” checks; any UI beyond the one
  extra line in `report()`.

## Approach

On `CheckOutcome::Failed` for a test-mode exercise (exit 0 only — not 2/3), the
runner attempts a bisection pass:

1. **Extract** the single `test :- <body>.` clause from the file's hidden
   section (below `% Do not edit below this line`). If `test/0` isn't exactly
   one clause whose body is a flat conjunction, bail to fallback.
2. **Split** the body on **top-level** commas, tracking `()`/`[]`/`{}` nesting
   (and quotes) so commas inside `( -> ; )`, list literals, and `findall`
   templates are protected. Record each conjunct's **source line** as we go.
3. **Binary-search** for the first failing conjunct. Prefix-provability is
   monotone — if `g1..gk` has no solution, no longer prefix can — so we probe
   `plgc run <file> --query "g1, …, gk"` at `k = N/2`, etc. ~⌈log₂N⌉ compiles
   instead of N. **Prefixes, not isolated goals**, because conjuncts thread
   variables (`titles_in(sci_fi, S), S == [...]`).
4. **Report** the first conjunct whose prefix flips provable→unprovable: its
   index `k/N`, its source line, and its text.

New surface: a `Failed` variant (or a sibling outcome) carrying optional blame
`{ index, total, line, goal }`; `exercise.rs` threads it into `Status::Failed`;
`report()` prints the one extra line. The bisection lives behind a function in
`runner.rs` that takes the file + parsed conjuncts and returns `Option<Blame>`.

## Domain Events

- **Consumes:** `CheckOutcome::Failed` (exit 0) for a `mode = "test"` exercise.
  Parse/runtime/invocation errors and parse-mode are untouched.
- **Produces:** a `Blame { index, total, line, goal }` (or `None`). `None` ⇒
  render exactly today's message — the fallback path is a first-class outcome,
  not an error.
- **Must follow:** each bisection probe is an extra `plgc` subprocess; these
  fire **only** on a failing test-mode check, never on green runs, and are
  bounded to ~log₂N per failure. The watcher still re-checks only the current
  exercise on a real content change.

## Checkpoints

1. **Splitter unit tests** over real corpus bodies: `06-traffic` (9 checks,
   `( -> ; )`), `05-collect` (shared `S`, list literal, `findall` template),
   `04-once` (`==`, nested `findall`). Commas inside parens/lists never split.
2. **Blame is correct**: feed the known-broken `action/2` (missing the `; A=go`
   else) and assert blame = `action(green, go)` at its line. Feed a wrong
   expected-list in a `05-collect`-style test and assert blame lands on the
   `S == [...]` check, **not** the `findall` before it (variable-threading proof).
3. **Fallback is safe**: a `test/0` with a helper predicate, or a runtime-error
   failure, yields the unchanged opaque message — no panic, no false blame.
4. **No regression**: `tests/curriculum.rs` unchanged and green; `just ci`
   green; manual watch run shows zero extra compiles on a passing exercise.
