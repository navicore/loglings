% Solution: 03-standard-order

precedes(X, Y) :- X @< Y.

% Do not edit below this line

test :-
    precedes(1, a),
    precedes(a, foo(x)),
    precedes(1, 2),
    precedes(apple, banana),
    precedes(1.0, 1),
    \+ precedes(foo(x), 9),
    \+ precedes(2 + 2, 5).
