% Solution: 01-commit

candidate(alice).
candidate(bob).
candidate(carol).

pick(X) :- candidate(X), !.

% Do not edit below this line

test :-
    pick(P),
    P == alice,
    findall(X, pick(X), L),
    L == [alice].
