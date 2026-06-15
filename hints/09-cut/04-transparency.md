# Hint — 04-transparency

This one is mostly a copy-the-shape exercise — the point is to SEE the
behavior, not to invent it. Write `t(X)` as a single clause whose body is
the disjunction shown in the text: `m(X), X > 1, !` in the first branch,
`X = fallback` in the second, wrapped in `( ... ; ... )`.

If your `findall` comes back as `[2, fallback]` instead of `[2]`, your
engine isn't cutting transparently — but on plgc it should be `[2]`.
That's the whole lesson: the cut reaches out past its own branch.
