# Hint — 03-compound-terms

Two built-ins do the work: `functor(Term, Name, Arity)` reads the functor name,
and `arg(N, Term, A)` reads the Nth argument.

Your rule body calls both — one for the name, one for the first argument. You
don't need the arity here, so bind it to an `_`-prefixed variable and leave it.
