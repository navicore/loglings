# Hint — 05-robust-eval

Two pieces, working as a pair — the same division of labour as chapter 15's
capstone, but here the balls are the engine's own arithmetic errors.

**`classify/2`** is a little lookup table, one clause per error shape. Each
clause has an `error(Formal, _)` term in the first argument and the name you
want in the second: `evaluation_error(zero_divisor)` maps to `divide_by_zero`,
`evaluation_error(int_overflow)` to `overflow`, `type_error(evaluable, _)` to
`not_evaluable`. Match on the Formal; leave the context slot (and the type
error's culprit) as `_`.

**`eval/2`** is one `catch/3`. The Goal does two things together: evaluate the
expression with `is`, and wrap the value as `ok(Value)`. The Catcher is an open
variable so it receives any ball; the Recovery hands that ball to `classify`,
which turns it into the reported name. On the no-error path the Goal succeeds
and the catcher never fires.

The error you can't add a `classify` clause for is `resource_error(steps)` —
nothing catches it, so it never reaches your handler. That's the boundary the
whole chapter has been pointing at.
