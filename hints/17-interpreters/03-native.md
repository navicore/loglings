# Hint — 03-native

A goal like `Y is V * 2` has no `clause/2` entry — so prove must recognise it
and `call` it natively.

Add a small table `builtin/1` with one fact per shape you want called
natively. The pattern `_ is _` matches any `is/2` goal; `(_ = _)` would match
any unification. Then a prove clause: if the goal matches the table, `call` it.

Place the native-escape clause before the clause-lookup clause so builtins are
caught first. Keep `prove`'s other three clauses from 02-conjunction.
