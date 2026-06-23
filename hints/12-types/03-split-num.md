# Hint — 03-split-num

Three clauses. The base case: splitting the empty list gives two empty
lists.

Then one recursive clause per bucket. If the head is an `integer`, put it on
the front of the integers result and recurse on the tail — the floats result
just passes straight through. If the head is a `float`, mirror it: put it on
the front of the floats result, pass the integers result through.

The type test (`integer(H)` or `float(H)`) sits at the start of each
recursive clause and decides which one applies to this head.
