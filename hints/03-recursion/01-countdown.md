# Hint — 01-countdown

Two clauses. The base case is a fact (no body). The recursive step is a
rule whose body has THREE goals in order: the guard, the arithmetic, the
recursive call.

## Solution sketch

    countdown(0).
    countdown(N) :- N > 0, N1 is N - 1, countdown(N1).
