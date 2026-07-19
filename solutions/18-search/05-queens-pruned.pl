% Solution: 05-queens-pruned

queens(N, Rows) :- place(N, N, [], Rows).

place(0, _, Rows, Rows).
place(K, N, Placed, Rows) :-
    K > 0,
    between(1, N, R),
    no_attack(R, Placed, 1),
    K1 is K - 1,
    place(K1, N, [R | Placed], Rows).

no_attack(_, [], _).
no_attack(R, [P|Ps], D) :-
    R =\= P,
    R =\= P + D,
    R =\= P - D,
    D1 is D + 1,
    no_attack(R, Ps, D1).

% Do not edit below this line

test :-
    findall(S, queens(4, S), S4),
    member([2, 4, 1, 3], S4),
    member([3, 1, 4, 2], S4),
    findall(S, queens(6, S), S6),
    length(S6, 4).
