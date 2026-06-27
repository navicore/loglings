# Hint — 03-selective

Still a single `catch` around `R is Expr`. Everything rides on the *catcher*
being narrow.

You want to catch a type error and nothing else. A type error's Formal is
`type_error(Type, Culprit)` — but you don't care which type or which culprit,
so both of those slots can be anonymous. Wrap that in the standard
`error(Formal, _)` envelope.

Because that catcher's shape is `type_error(...)`, it simply won't unify with
an `evaluation_error(...)` ball. That non-match is doing the work: the
divide-by-zero error finds no match here and keeps travelling outward, which
is exactly what the test's outer `catch` is there to receive. Recovery for the
type case is one unification settling R on -1.

If you find yourself reaching for `catch(_, _, ...)` to make the test pass,
that's the over-greedy catcher the exercise is warning against — it would
swallow the zero-divisor too.
