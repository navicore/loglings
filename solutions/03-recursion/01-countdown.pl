% Solution: 01-countdown

countdown(0).
countdown(N) :- N > 0, N1 is N - 1, countdown(N1).

% Do not edit below this line

test :- countdown(5), countdown(0).
