# Hint — 01-operators-are-terms

`Term =.. List` turns a term into `[Functor | Args]` and back again. For an
infix expression like `2 + 3`, the functor *is* the operator.

So unifying the expression with `[Op, Left, Right]` via `=..` hands you all
three pieces at once. One goal does it.
