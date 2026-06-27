# Hint — 01-catch-recover

`price_or` is a single `catch`. The Goal is the `lookup` call you were given —
let it run, and most of the time it just succeeds and binds P for you.

The interesting case is when `lookup` can't find the item and throws. The ball
it throws is `no_price(Item)`, so your Catcher needs to be a term of that
shape. You don't care *which* item was missing here, so the catcher can leave
that slot anonymous.

When the catcher matches, the Recovery goal runs in place of the failed
lookup. Its whole job is to settle P on the default that was handed in — a
single unification does that. Think about which of `catch`'s three arguments
is the right home for it.
