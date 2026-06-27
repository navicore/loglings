# Hint — 04-fixed-syntax

**`build_sum/3`** uses `=..` (the "univ" operator from chapter 11) in its
BUILD direction: a term on the left, a list of `[Functor | Args]` on the right.
The functor you want is the atom `+`, and the two arguments are A and B. The
term that comes out is identical to what you'd type as `A + B` — that's the
whole point, and it's why `T == 3 + 4` holds: `3 + 4` is just `+(3, 4)` written
with sugar.

**`eval_sum/3`** builds that same term and then evaluates it with `is`. Since
the built compound and the infix form are one and the same term, `is` treats
them identically — feed the constructed Term straight to `is`.

The exercise never needs a custom operator: the fixed table plus `=..` lets you
construct any expression you like as an ordinary compound.
