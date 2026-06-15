% Solution: 01-member

shared(A, B, X) :- member(X, A), member(X, B).

% Do not edit below this line

test :-
    shared([a, b, c], [x, b, c], b),
    \+ shared([a, b], [c, d], _),
    findall(X, shared([1, 2, 3], [2, 3, 4], X), L),
    L == [2, 3].
