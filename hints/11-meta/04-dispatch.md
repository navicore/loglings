# Hint — 04-dispatch

Two goals, the two builtins this chapter leaned on, in order. First turn
the name and its two arguments into a real goal with `=..` — remember the
list is `[Functor | Args]`, so the name leads and the arguments follow.
Then hand that goal to `call`.

The name chooses the predicate, `=..` makes it a goal, `call` runs it. You
never name `double` or `negate` yourself — that's the point.
