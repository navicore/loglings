% Solution: 05-both-ways

adjacent(X, Y) :- succ(X, Y).
sum3(A, B, C) :- plus(A, B, C).

% Do not edit below this line

test :-
    adjacent(3, Y),
    Y == 4,
    adjacent(X, 10),
    X == 9,
    sum3(2, 3, S),
    S == 5,
    sum3(2, B, 5),
    B == 3,
    sum3(A, 3, 5),
    A == 2.
