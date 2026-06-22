# Hint — 01-all-pass

Same two-clause shape as the recursions in the comment. The base case: the
empty list passes trivially, no matter the test. The recursive case: the
head must satisfy the test, and the tail must all pass too.

The only new part is the test itself. You can't write the predicate's name
— it arrived in `Pred` — so hand `Pred` and the head element to `call` and
let it run the check.
