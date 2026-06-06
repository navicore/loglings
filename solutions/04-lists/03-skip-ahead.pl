% Solution: 03-skip-ahead

second([_, S|_], S).

% Do not edit below this line

:- dynamic(second/2).
test :-
    second([a, b, c], S1), S1 = b,
    second([1, 2], S2), S2 = 2,
    second([x, y, z, w], S3), S3 = y,
    \+ second([only], _),
    \+ second([], _).
