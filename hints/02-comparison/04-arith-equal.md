# Hint — 04-arith-equal

The rule body has a single goal: `=:=` between the two arguments.

If you write `same_value(A, B) :- A = B.` instead, the test
`same_value(2 + 3, 5)` will fail — `=` tries to unify the literal
term `2 + 3` with `5`, and those are different terms. `=:=` is the
operator that knows to evaluate arithmetic first.

## Solution sketch

    same_value(A, B) :- A =:= B.
