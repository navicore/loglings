# Hint — 02-prefix-and-infix

The form follows the arity: a prefix operator wraps one argument, an infix
operator joins two. So `functor/3`'s arity is all you need to look at.

Two clauses, mirroring the previous chapter: one maps arity 1 to `prefix`, the
other maps arity 2 to `infix`.
