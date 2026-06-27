# Hint — 01-overflow

This is the same `catch/3` shape as chapter 15's `safe_div`, pointed at a
different error. The Goal is `fact(N, F)` — already written for you. The Catcher
is the overflow error's shape: an `error(...)` term whose Formal is
`evaluation_error(int_overflow)`, with a `_` in the context slot so it matches
regardless of the message. The Recovery just binds `F` to the atom `too_big`.

On the normal path the catch is invisible: `fact` succeeds and `F` is the
number. Only when a multiplication overflows does the thrown ball reach your
catcher and the recovery fire. Don't match on the culprit details inside the
error — match on its shape and let the context be anything.
