# Hint — 02-safe-sum

Base case: the empty list sums to 0.

Recursive case: get the total of the tail first (call it `S0`), then decide
what to do with the head. An if-then-else does it: `( number(H) -> S is S0
+ H ; S = S0 )`. If the head is a number, the running total grows by it; if
not, the total is unchanged and the head is simply dropped.

Recursing before the guard means `S0` is ready when you need it, whichever
branch you take.
