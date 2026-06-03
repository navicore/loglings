% Solution: 01-atoms-and-numbers

kind(X, atom)   :- atom(X).
kind(X, number) :- number(X).

% Do not edit below this line

test :-
    kind(apple, atom),
    kind(42, number),
    kind(banana, atom),
    kind(7, number).
