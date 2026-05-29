# Hint — 05-arith-not-equal

Two body goals: look up the score, then check it isn't 100.

## Solution sketch

    not_perfect(S) :- score(S, X), X =\= 100.
