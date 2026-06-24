# Hint — 04-spell

One clause, three goals, and the first and last are the same builtin run in
opposite directions.

Start by spelling the atom out into a list of characters with `atom_chars`
(atom bound, list open). Reverse that list with `reverse/2` from chapter 10.
Then assemble the reversed characters back into an atom by running
`atom_chars` the other way — this time the list is the bound argument and the
atom is the one left open.

The thing to remember is that you don't need a second, different builtin to
go from characters back to an atom: it's the same `atom_chars`, just with the
bound and unbound arguments swapped.
