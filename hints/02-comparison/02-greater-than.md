# Hint — 02-greater-than

Same pattern as the kid exercise — look up the age, then test it. Just
flip the operator and the threshold.

## Solution sketch

    adult(P) :- age(P, A), A > 17.
