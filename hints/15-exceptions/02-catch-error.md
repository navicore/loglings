# Hint — 02-catch-error

`safe_div` is one `catch`, just like the last exercise — only this time the
Goal is the arithmetic itself (`R is A // B`), and the ball you're catching is
one the engine throws, not one you wrote.

The Goal: let the division run normally. When B isn't zero it succeeds and
binds R, and the catcher never fires — including the `0 // 5` case, where the
*answer* is 0 but no error happened.

The Catcher: division by zero throws `error(evaluation_error(zero_divisor), _)`.
Name that Formal exactly and leave the context as `_`. Matching it narrowly
(rather than catching every `error(_, _)`) is the point — a different,
unexpected error should still be allowed to surface.

The Recovery: settle R on 0 with a single unification.
