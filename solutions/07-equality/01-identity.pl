% Solution: 01-identity

same_term(X, Y) :- X == Y.

% Do not edit below this line

test :-
    same_term(a, a),
    same_term(foo(1, b), foo(1, b)),
    \+ same_term(a, b),
    \+ same_term(1, 1.0),
    \+ same_term(_, hello).
