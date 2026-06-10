# Hint — 01-identity

One goal in the body: the two arguments with the identity operator
between them. No binding, no arithmetic — just "are these already the
same term?".

The `\+ same_term(1, 1.0)` case is the one to trust the operator on:
`1` and `1.0` are different *terms*, so identity says no — even though
they're equal as numbers.
