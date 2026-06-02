# Design: `02-terms` and `03-operators` chapters

Status: approved, not yet built. Verified passing on `prlg` 0.4.1.

## Motivation

The curriculum introduces comparison (`=:=` vs `=`, `age/2` facts) before ever
teaching the term model it rests on. Concrete seams in the current files:

- `02-comparison/01` says "a few `age/2` facts" — first sight of `name/arity`
  notation, never explained.
- "functor" leaks into `hints/00-intro/*` as if already known.
- `02-comparison/04` (`=:=` vs `=`) asks the learner to grasp "`2 + 3` is a
  *term*, not a number, and `=` is unification over terms" with zero runway.
- `01-arithmetic` asserts precedence/associativity (`10 - 3 - 2` is `(10-3)-2`)
  without explaining it's how infix sugar maps onto compound terms.

Missing layer: **the term model** — atoms, numbers, variables, compound terms;
functor + arity = predicate identity (`name/N`); operators as sugar for compound
terms; precedence/associativity as the disambiguation rule.

## Decisions

- **Two new chapters**, inserted after `01-arithmetic`:
  `02-terms` (4 exercises) and `03-operators` (3). Arity alone and associativity
  alone are each too thin to stand as chapters; the term taxonomy is the
  foundation that contains both.
- **Order:** terms/operators come *after* arithmetic so that `+ * //` are
  already in hand when we dissect them, and *before* comparison so the
  `=:=` vs `=` / `age/2` material finally has its footing.
- Renumber `02-comparison` → `04-comparison`, `03-recursion` → `05-recursion`
  (content unchanged).
- **Hints are nudges, not answers.** Strip the `## Solution sketch` from every
  hint project-wide; solutions stay in `solutions/`.

## Engine notes (prlg 0.4.1)

- Operators are usable as bare atoms in term position (patch-prolog #19, fixed),
  so `01-operators-are-terms` writes `+`/`*`/`-` directly — no quoting needed.
- Learner-supplied **fact** predicates get `:- dynamic(F/A).` in the hidden
  section so an un-started file fails as `false.` rather than throwing.
- **Operator fixity is partial, by engine design.** prlg supports prefix (`-`,
  `\+`) and infix; it has no postfix operators and no `op/3`. The
  prefix/infix exercise uses only `-`/`\+`/infix — all runnable on 0.4.1 — and
  the prose presents postfix as "the language has it; this engine is a
  deliberate subset" (engine-boundary lesson). Tracked engine gaps: #28, #29,
  #31.

## Curriculum order (after this change)

```
00-intro · 01-arithmetic · 02-terms · 03-operators · 04-comparison · 05-recursion
```

## Exercises

Each `.pl` has teaching prose, a task stub, the `% I AM NOT DONE` marker, then a
hidden `test/0` below `% Do not edit below this line` (`mode = "test"`).

### 02-terms/01-atoms-and-numbers — the two simplest terms
Atoms (lowercase constants) vs numbers; `atom/1` / `number/1` as discriminators.
Two clauses, one per kind.
```prolog
% task:
kind(X, atom)   :- atom(X).
kind(X, number) :- number(X).
% test:
test :- kind(apple, atom), kind(42, number), kind(banana, atom), kind(7, number).
```

### 02-terms/02-variables-unify — variables and `=`
Uppercase = variable; `=` is unification (matches structure, binds vars) and
does **not** evaluate — `2 + 3` stays the term, not `5`. Seeds `=:=` vs `=`.
```prolog
% task (a fact; declared dynamic in the hidden section):
as_term(2 + 3).
% test:
test :- as_term(T), T = 2 + 3, \+ ( T = 5 ).
```

### 02-terms/03-compound-terms — functor + arguments
A compound term is a functor plus positional args; the facts you've written
*are* compound terms. Inspect with `functor/3` and `arg/3`.
```prolog
% task:
describe(T, Name, First) :- functor(T, Name, _Arity), arg(1, T, First).
% test:
test :- describe(age(ann, 9), age, ann), describe(point(3, 4), point, 3).
```

### 02-terms/04-arity — why we write `age/2`
The arity ignored above is part of a predicate's identity. `note/1` and
`note/2` are *different predicates* that share a name.
```prolog
% given:
note(c).  note(d).  note(e).
note(c, 261).  note(a, 440).
% task:
arity_of(T, N)  :- functor(T, _Name, N).
freq(Name, Hz)  :- note(Name, Hz).
% test:
test :- arity_of(note(c), 1), arity_of(note(c, 261), 2), freq(c, 261), freq(a, 440).
```

### 03-operators/01-operators-are-terms — the aha
`+ - * < , :-` are operators (sugar); `2 + 3` *is* `+(2, 3)`. `=..` reveals it.
```prolog
% task:
decompose(E, Op, L, R) :- E =.. [Op, L, R].
% test:
test :- decompose(2 + 3, +, 2, 3), decompose(10 * 4, *, 10, 4), decompose(a - b, -, a, b).
```

### 03-operators/02-prefix-and-infix — notation forms, tied to arity
Operators come in forms: **prefix** (operator before its one argument: `- X`,
`\+ Goal`) and **infix** (between its two: `a + b`). Both are just compound
terms — the form only changes how you *write* them. Prefix ops are arity 1,
infix arity 2, and the *same* `-` is both prefix `-/1` (negation) and infix
`-/2` (subtraction) — **arity is what distinguishes them** (callback to
`02-terms/04`). Prose footnote: Prolog also has postfix, but this engine is a
deliberate subset that doesn't implement it. Authoring trap: use `- a`, never
`- 3` (`-3` folds to a negative *number*, not a compound).
```prolog
% task:
notation(T, prefix) :- functor(T, _, 1).
notation(T, infix)  :- functor(T, _, 2).
% test:
test :- notation(- a, prefix), notation(\+ foo, prefix),
        notation(a - b, infix), notation(2 + 3, infix).
```

### 03-operators/03-precedence-assoc — why grouping happens
`*` binds tighter than `+`; `-` is left-associative, so `10 - 3 - 2` is
`(10-3)-2 = 5`. Closes the loop with `01-arithmetic`.
```prolog
% task:
answer(X)       :- X is (2 + 3) * 4.     % parens beat * precedence -> 20
same_as_bare(Y) :- Y is (10 - 3) - 2.    % pick the left-assoc grouping
% test:
test :- answer(20), X is 10 - 3 - 2, same_as_bare(Y), Y =:= X, Y =:= 5.
```

## Build checklist

- [ ] Add 7 exercise files under `exercises/02-terms/` and `exercises/03-operators/`.
- [ ] Add matching `solutions/` and nudge-only `hints/`.
- [ ] `mv` `02-comparison` → `04-comparison`, `03-recursion` → `05-recursion`
      in all three trees.
- [ ] Update `exercises/info.toml`: insert the 7 new entries; fix renumbered paths.
- [ ] Strip `## Solution sketch` from every existing hint.
