# Hint — 02-conjunction

`prove` needs three clauses now, one per shape it meets:

- `true` — the body of every fact; succeed.
- `(A, B)` — a conjunction. Split it and prove each side.
- any other goal — look up its clause with `clause/2` and prove the body.

Recursion takes care of itself: proving a body calls `prove` on the goal
inside it, exactly like the original query. The recursive `path/2` rule works
with no special handling.
