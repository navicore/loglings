# Hint — 03-call

The whole point is that `relate` doesn't know the predicate name ahead of
time — `Pred` is a parameter. So you can't write the relation's name; you
hand `Pred` to `call` and let it supply `A` and `B` as the two arguments.

One goal in the body. The worked example showed the extra-argument form of
`call`; yours appends two.
