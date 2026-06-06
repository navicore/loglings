% Solution: 02-factorial

factorial(0, 1).
factorial(N, F) :-
    N > 0,
    N1 is N - 1,
    factorial(N1, F1),
    F is N * F1.

% Do not edit below this line

test :-
    factorial(0, F0), F0 = 1,
    factorial(1, F1), F1 = 1,
    factorial(5, F5), F5 = 120,
    factorial(7, F7), F7 = 5040.
