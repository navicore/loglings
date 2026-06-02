# Hint — 01-atoms-and-numbers

You need two clauses, one per kind. Prolog has built-in tests `atom/1` and
`number/1` — let each clause guard on the one that matches its label.

The shape of a clause here is "X is of kind K *if* some test of X holds."
