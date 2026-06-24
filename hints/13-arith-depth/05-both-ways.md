# Hint — 05-both-ways

Each predicate is a single clause that names the builtin relation. For
`budget_left(Budget, Spent, Left)`, the fact is `Spent + Left = Budget` —
write that as `plus(Spent, Left, Budget)`. For `next_page(Page, Next)`, the
next page is the successor — `succ(Page, Next)`.

The trick is what you DON'T do: don't reach for `is/2`. `plus` and `succ`
already work in every direction, so the moment you build on them your own
predicate does too — the unbound argument, wherever the caller left it, is
the one the builtin solves for. Picking `is` and a `-` or `+` would lock the
predicate to one direction and throw the any-direction power away.
