# Hint — 05-both-ways

Each predicate is a single clause that just names the builtin relation —
`adjacent` on `succ/2`, `sum3` on `plus/3`. Pass the arguments straight
through in the same order.

The trick is what you DON'T do: don't reach for `is/2`. `succ` and `plus`
already work in every direction, so the moment you build on them your own
predicate does too — the unbound argument, wherever the caller left it, is
the one the builtin solves for. Writing `Y is X + 1` would throw the
two-way power away.
