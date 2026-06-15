# Hint — 03-cut-fail

Lean on unification in the clause head. If you write the first clause
head with the SAME variable name in both argument slots, it only matches
when the two arguments are equal — and that's exactly the case you want
to reject with `!, fail`.

The second clause is the catch-all with two anonymous `_` arguments. Two
clauses, that's all. The `\+ different(a, a)` checks are confirming the
reject path fires.
