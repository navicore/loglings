# Hint — 01-measure

Two clauses, the same sum-a-list shape from chapter 06 — only with a
measurement step before each addition.

Think about the empty list first: there are no atoms to measure, so the total
can only be one thing. That's your base case.

The recursive clause takes the list apart into a head and a tail. Measure the
head with `atom_length` (it relates an atom to its character count), recurse
on the tail to get the total of everything else, and add those two numbers
with `is`. The recursion bottoms out on its own as the tail shrinks to empty.
