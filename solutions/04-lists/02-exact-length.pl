% Solution: 02-exact-length

duo([X, Y], X, Y).

% Do not edit below this line

:- dynamic(duo/3).
test :-
    duo([a, b], A, B), A = a, B = b,
    duo([1, 2], One, Two), One = 1, Two = 2,
    \+ duo([a], _, _),
    \+ duo([a, b, c], _, _).
