# Hint — 02-factorial

Same shape as countdown, with one extra step at the end: multiply the
smaller factorial by N.

## Solution sketch

    factorial(0, 1).
    factorial(N, F) :-
        N > 0,
        N1 is N - 1,
        factorial(N1, F1),
        F is N * F1.
