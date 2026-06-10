# Hint — 04-compare

A single call to `compare/3`. The trick is argument order: the result
atom comes FIRST, then the two terms — `compare(O, X, Y)` — and your
predicate just threads its own arguments straight through.

You don't build the `<`/`=`/`>` answer yourself; `compare` hands it to
you in O.
