# Hint — 04-non-local-exit

Two predicates. `product` is the thin wrapper: a single `catch` around a call
to your helper, with a recovery that sets P to 0. Pick any atom as the ball
(something like `zero` reads well) — the only rule is that the catcher in
`product` names the *same* ball your helper throws.

The helper is the multiply-a-list recursion. Its base case is the empty list,
which contributes the empty product — the value that leaves a product
unchanged. Then two clauses for a non-empty list:

- when the head is 0, don't recurse and don't multiply — just `throw` the
  ball. That's the jump out; everything still pending is abandoned.
- when the head is non-zero, recurse on the tail and multiply it in. Guard
  this clause (compare the head against 0) so it never competes with the
  zero clause.

Remember chapter 01's ordering rule: the recursive call has to come before the
`is` that multiplies its result in.
