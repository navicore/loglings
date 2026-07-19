# Hint — 05-queens-pruned

`place/4` has the usual two clauses. The base case: no queens left to place
(`K = 0`), so `Placed` is the answer. The recursive case: pick a row `R` with
`between(1, N, R)`, **check it immediately** with `no_attack(R, Placed, 1)`,
and only then recurse with `[R | Placed]` and `K - 1`. The early check is the
whole point — a bad row never gets recursed on.

`no_attack/3` walks `Placed` with a growing distance `D` (start at 1). The base
case: an empty `Placed` list is trivially safe. Otherwise the new row `R` must
survive three tests against the nearest placed row `P` — `R =\= P` (not the
same row), `R =\= P + D` and `R =\= P - D` (not on either diagonal) — and then
recurse on the tail with `D + 1`.
