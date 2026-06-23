% Solution: 03-int-pow

int_pow(Base, Exp, P) :- P is Base ^ Exp.

% Do not edit below this line

test :-
    int_pow(2, 10, P),
    P == 1024,
    integer(P),
    int_pow(5, 3, Q),
    Q == 125,
    F is 2 ** 10,
    float(F),
    F =:= 1024,
    G is 7 / 2,
    float(G),
    G =:= 3.5,
    H is 7 // 2,
    integer(H),
    H == 3.
