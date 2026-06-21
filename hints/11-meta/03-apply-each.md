# Hint — 03-apply-each

The two lists move together. Base case: an empty input gives an empty
output. Recursive case: the output list has its own head and tail, just
like the input.

Relate the input head to the output head with `call` — three arguments
this time: the operation, the element, and the variable that will hold its
result. Then recurse so the input tail produces the output tail.
