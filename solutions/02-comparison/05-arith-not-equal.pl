% Solution: 05-arith-not-equal

score(ann, 87).
score(bob, 100).
score(carol, 92).
score(dan, 100).
score(eve, 73).

not_perfect(S) :- score(S, X), X =\= 100.

% Do not edit below this line

test :-
    findall(S, not_perfect(S), Imperfect),
    Imperfect = [ann, carol, eve].
