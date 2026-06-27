# Hint — 03-true-fail

Three small predicates, each a body of one goal.

**`always`** and **`never`** are the most literal exercises in the chapter:
the body of one is the goal `true`, the body of the other is the goal `fail`.
That's the whole point — these are goals you can write directly, because
`true/0` and `fail/0` are predicates the engine already provides.

**`open/1`** is an if-then-else (from the last exercise) whose two branches are
those same goals. The test is "is this door the vault?" — reach for `==` from
chapter 07 to compare the name. If it is the vault, the branch is `fail`; the
fall-through `;` branch is `true`, so every other door succeeds. The `true`
here is doing real work: it's the default that lets any door you didn't single
out through, which a list of facts could never cover.
