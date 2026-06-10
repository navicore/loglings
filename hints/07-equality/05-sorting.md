# Hint — 05-sorting

Each predicate is a single call that hands its work to a builtin and
passes the result straight back. The only decision is which builtin:
the one that keeps duplicates, or the one that drops them.

Remember the names are slightly counterintuitive: the *shorter* name
(`sort`) is the one that does *more* — it also removes duplicates.
