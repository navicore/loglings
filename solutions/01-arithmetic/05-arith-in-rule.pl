% Solution: 05-arith-in-rule

square(N, Sq) :- Sq is N * N.

% Do not edit below this line

test :-
    square(5, A),  A = 25,
    square(9, B),  B = 81,
    square(12, C), C = 144.
