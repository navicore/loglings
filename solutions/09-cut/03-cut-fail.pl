% Solution: 03-cut-fail

different(X, X) :- !, fail.
different(_, _).

% Do not edit below this line

test :-
    different(a, b),
    \+ different(a, a),
    different(1, 2),
    \+ different(foo, foo).
