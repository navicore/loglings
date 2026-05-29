# Hint — 03-less-equal-greater-equal

You need TWO comparisons in the body — the age must be at least 13 AND
at most 19. Comma separates body goals and reads as "and".

Remember it's `=<`, not `<=`.

## Solution sketch

    teen(P) :- age(P, A), A >= 13, A =< 19.
