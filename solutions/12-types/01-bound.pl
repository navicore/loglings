% Solution: 01-bound

coalesce(In, _, In) :- nonvar(In).
coalesce(In, D, D)  :- var(In).

% Do not edit below this line

test :-
    coalesce(5, 0, R1),
    R1 == 5,
    coalesce(hello, def, R2),
    R2 == hello,
    coalesce(X, 99, R3),
    R3 == 99,
    coalesce(Y, fallback, R4),
    R4 == fallback,
    var(Y).
