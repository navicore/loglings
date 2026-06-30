# Hint — 03-no-database

**`no_db/1`** is a `catch/3` like the others. The Goal tries `assertz(seen(1))`
— which throws, because `assertz/1` is undefined here. The Catcher matches the
existence-error shape, `error(existence_error(procedure, _), _)`, leaving the
name/arity culprit as `_`. The Recovery binds Result to `no_database`. (A
stderr warning may print on the way — ignore it; the catch still succeeds.)

**`running_total/3`** is the accumulator pattern, the assert-free way to carry a
changing value. Two clauses: when the list is empty, the answer is whatever the
accumulator has reached — nothing left to add. When there's a head and a tail,
add the head to the accumulator to get a new running value, and recurse on the
tail carrying that forward. The total only "comes out" at the empty-list base
case, handed back through the third argument.
