% Solution: 04-queens-naive

all_member([], _).
all_member([H|T], D) :- member(H, D), all_member(T, D).

safe([]).
safe([Q|Qs]) :- \+ attack(Q, 1, Qs), safe(Qs).

queens(Rows) :-
    length(Rows, 4),
    all_member(Rows, [1, 2, 3, 4]),
    safe(Rows).

attack(Q, D, [Q2|_]) :- Q =:= Q2 + D.
attack(Q, D, [Q2|_]) :- Q =:= Q2 - D.
attack(Q, _, [Q2|_]) :- Q =:= Q2.
attack(Q, D, [_|Qs]) :- D1 is D + 1, attack(Q, D1, Qs).

% Do not edit below this line

test :-
    findall(S, queens(S), Solutions),
    Solutions = [_, _],
    member([2, 4, 1, 3], Solutions),
    member([3, 1, 4, 2], Solutions).
