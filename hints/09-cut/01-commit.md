# Hint — 01-commit

One clause: call `candidate(X)`, then put `!` after it (joined by a
comma, like any two goals). The cut does the "stop after the first" work
— you don't filter anything yourself.

The `findall(... pick ...) == [alice]` check is the tell: it must yield
exactly one answer, not all three candidates.
