# Design: `04-lists` chapter

Status: built and in the curriculum. Verified passing on `plgc` (patch-prolog2).

## Motivation

Field feedback from working the curriculum: `05-recursion/03-sum-list`
introduced `[H|T]` destructuring *inside* the recursion chapter — two new
ideas at once, and the harder one (recursion) became the backdrop for
sneaking in the other. Destructuring isn't a recursion concept at all: it's
unification of compound terms (the `02-terms` material) wearing list syntax.

Teach it first-class and non-recursively; then the recursion chapter's
sum-list / my-length / double-each are purely about recursion applied to a
structure the learner already knows how to take apart.

## Decisions

- **One new chapter, `04-lists` (4 exercises), after `03-operators`.** This
  completes the "term model" arc — `02-terms` → `03-operators` →
  `04-lists` (list syntax is more sugar over terms) — before the
  "computation" arc of comparison and recursion.
- Renumber `04-comparison` → `05-comparison`, `05-recursion` → `06-recursion`
  (content unchanged except the sum-list trim below).
- **Trim the destructuring tutorial out of sum-list**: it now *recalls*
  `[H|T]` rather than teaching it.
- `00-intro/05-list` stays as-is: it only establishes that lists exist and
  `member/2` checks membership — a teaser, not a destructuring lesson.

## Compiler notes (plgc)

All four pattern shapes verified directly, including the negative cases:

- `[H|T]` / `[H|_]` / `[_|T]` — head/tail of any non-empty list.
- `[X, Y]` — *exactly* two elements (fails on one or three).
- `[_, S|_]` — skip elements before the `|`.
- `[B, A|T]` as a clause-head **output** — heads build as well as match.
- Learner-supplied fact predicates get `:- dynamic(F/A).` in the hidden
  section (project convention) so an un-started file fails as `false.`
  rather than throwing.

## Exercises

Each `.pl` has teaching prose, a task stub, the `% I AM NOT DONE` marker, then
a hidden `test/0` below `% Do not edit below this line` (`mode = "test"`).

### 04-lists/01-head-and-tail — `[H|T]` is unification
A list is a term; `[H|T]` unifies with any non-empty list, binding head and
tail in one match. Callback to `02-terms/02`.
```prolog
% task:
first([H|_], H).
rest([_|T], T).
% test (highlights: single-element list has tail []):
test :- first([10, 20, 30], 10), rest([10, 20, 30], [20, 30]),
        first([only], only), rest([only], []).
```

### 04-lists/02-exact-length — `[X, Y]` vs `[X|T]`
No `|` means *exact* shape: `[X, Y]` matches only two-element lists, while
`[X|T]` matches one-or-more. The test's negative cases make the difference
load-bearing.
```prolog
% task:
duo([X, Y], X, Y).
% test:
test :- duo([a, b], a, b), duo([1, 2], 1, 2),
        \+ duo([a], _, _), \+ duo([a, b, c], _, _).
```

### 04-lists/03-skip-ahead — `_` and multi-element prefixes
Several elements may appear before the `|`; `_` matches anything you don't
care about. `[_, S|_]` reaches the second element of any list with at least
two.
```prolog
% task:
second([_, S|_], S).
% test:
test :- second([a, b, c], b), second([1, 2], 2), \+ second([only], _).
```

### 04-lists/04-rebuild — heads build, not just match
The same pattern syntax constructs lists when it appears in an output
position. Swap the first two elements, keeping the tail shared. This is the
seed for `06-recursion/05-double-each`.
```prolog
% task:
swap_first_two([A, B|T], [B, A|T]).
% test:
test :- swap_first_two([1, 2, 3], [2, 1, 3]), swap_first_two([a, b], [b, a]),
        \+ swap_first_two([x], _).
```

## Curriculum order (after this change)

```
00-intro · 01-arithmetic · 02-terms · 03-operators · 04-lists ·
05-comparison · 06-recursion
```

## Build checklist

- [x] `mv` `05-recursion` → `06-recursion`, then `04-comparison` →
      `05-comparison`, in all three trees.
- [x] Add 4 exercise files under `exercises/04-lists/` with matching
      `solutions/` and nudge-only `hints/`.
- [x] Update `exercises/info.toml`: insert the 4 new entries; fix renumbered
      paths.
- [x] Trim the `[H|T]` tutorial from `06-recursion/03-sum-list.pl` (recall,
      don't teach).
- [x] Refresh README and ROADMAP curriculum tables (7 chapters, 31
      exercises).
- [x] `just ci` green.
