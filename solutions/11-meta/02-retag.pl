% Solution: 02-retag

retag(Term, NewName, Result) :-
    Term =.. [_ | Args],
    Result =.. [NewName | Args].

% Do not edit below this line

test :-
    retag(point(3, 4), vector, R1),
    R1 == vector(3, 4),
    retag(node(a, b, c), leaf, R2),
    R2 == leaf(a, b, c),
    retag(foo(1), bar, R3),
    R3 == bar(1).
