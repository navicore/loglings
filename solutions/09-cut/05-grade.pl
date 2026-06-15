% Solution: 05-grade

grade(Score, a) :- Score >= 90, !.
grade(Score, b) :- Score >= 80, !.
grade(Score, c) :- Score >= 70, !.
grade(_, f).

% Do not edit below this line

test :-
    grade(95, G1),
    G1 == a,
    grade(85, G2),
    G2 == b,
    grade(72, G3),
    G3 == c,
    grade(50, G4),
    G4 == f,
    grade(90, G5),
    G5 == a,
    findall(G, grade(85, G), L),
    L == [b].
