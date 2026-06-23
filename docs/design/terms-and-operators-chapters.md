# Design: `02-terms` and `03-operators` chapters

Status: built and in the curriculum. Verified passing on `plgc` by CI.

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

## Compiler notes (plgc)

All verified against `plgc`.

- Operators are usable as bare atoms in term position, so
  `01-operators-are-terms` writes `+`/`*`/`-` directly — no quoting needed.
- Learner-supplied **fact** predicates get `:- dynamic(F/A).` in the hidden
  section so an un-started file fails as `false.` rather than throwing.
- **Prefix and infix are complete.** Usable: prefix `+ - \ \+`; infix incl.
  `** ^ >> << xor div /\ \/ :` alongside the arithmetic/comparison set. `^` is
  right-associative (`2^3^2 = 2^(3^2) = 512`), which `03-precedence-assoc` uses
  to contrast with left-associative `-`.
- **Postfix and `op/3` are unsupported — by compiler design** (an explicit
  exclusion in the ISO subset). This is the curriculum's engine-boundary lesson:
  "the language has postfix; this compiler is a deliberate subset."

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
Three ideas: **precedence** (`*` binds tighter than `+`), **left-associativity**
(`-`: `10 - 3 - 2` = `(10-3)-2` = 5), and **right-associativity** (`^`:
`2 ^ 3 ^ 2` = `2^(3^2)` = 512, *not* `(2^3)^2` = 64). The learner writes the
explicit parenthesization that matches each operator's grouping; a wrong choice
fails the test. Closes the loop with `01-arithmetic`.
```prolog
% task:
answer(X)        :- X is (2 + 3) * 4.    % parens beat * precedence -> 20
left_grouped(Y)  :- Y is (10 - 3) - 2.   % - left-assoc  -> 5
right_grouped(Z) :- Z is 2 ^ (3 ^ 2).    % ^ right-assoc -> 512
% test:
test :-
    answer(20),
    A is 10 - 3 - 2, left_grouped(Y),  Y =:= A, Y =:= 5,
    B is 2 ^ 3 ^ 2,  right_grouped(Z), Z =:= B, Z =:= 512.
```

## Build checklist

- [ ] Add 7 exercise files under `exercises/02-terms/` and `exercises/03-operators/`.
- [ ] Add matching `solutions/` and nudge-only `hints/`.
- [ ] `mv` `02-comparison` → `04-comparison`, `03-recursion` → `05-recursion`
      in all three trees.
- [ ] Update `exercises/info.toml`: insert the 7 new entries; fix renumbered paths.
- [ ] Strip `## Solution sketch` from every existing hint.
