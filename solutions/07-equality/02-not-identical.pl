% Solution: 02-not-identical

distinct(X, Y) :- X \== Y.

% Do not edit below this line

test :-
    distinct(a, b),
    distinct(1, 1.0),
    distinct(foo(1), foo(2)),
    \+ distinct(x, x),
    \+ distinct(foo(a, b), foo(a, b)).
