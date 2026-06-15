% Solution: 04-transparency

m(1).
m(2).
m(3).

t(X) :- ( m(X), X > 1, ! ; X = fallback ).

% Do not edit below this line

test :-
    findall(X, t(X), L),
    L == [2].
