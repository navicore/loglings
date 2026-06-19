% Solution: 05-describe

describe(L, N, Last) :-
    length(L, N),
    last(L, Last).

% Do not edit below this line

test :-
    describe([10, 20, 30], N, X),
    N == 3,
    X == 30,
    describe([a], N2, X2),
    N2 == 1,
    X2 == a.
