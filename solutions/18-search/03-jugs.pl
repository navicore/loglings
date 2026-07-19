% Solution: 03-jugs

solve(Path) :- bfs([node(s(0, 0), [s(0, 0)])], Path).

bfs([node(State, PathRev) | _], Path) :- goal(State), reverse(PathRev, Path).
bfs([node(State, PathRev) | Rest], Path) :-
    \+ goal(State),
    findall(node(N, [N | PathRev]), (move(State, N), \+ member(N, PathRev)), Succs),
    append(Rest, Succs, Frontier),
    bfs(Frontier, Path).

goal(s(A, _)) :- A =:= 2.

move(s(A, B), s(4, B)) :- A < 4.          % fill A
move(s(A, B), s(A, 3)) :- B < 3.          % fill B
move(s(A, B), s(0, B)) :- A > 0.          % empty A
move(s(A, B), s(A, 0)) :- B > 0.          % empty B

% pour A into B (B holds 3): A empties, or B fills.
move(s(A, B), s(0, B2)) :-
    A > 0, B < 3,
    Room is 3 - B, A =< Room,
    B2 is B + A.
move(s(A, B), s(A2, 3)) :-
    A > 0, B < 3,
    Room is 3 - B, A > Room,
    A2 is A - Room.

% pour B into A (A holds 4): B empties, or A fills.
move(s(A, B), s(A2, 0)) :-
    B > 0, A < 4,
    Room is 4 - A, B =< Room,
    A2 is A + B.
move(s(A, B), s(4, B2)) :-
    B > 0, A < 4,
    Room is 4 - A, B > Room,
    B2 is B - Room.

% Do not edit below this line

test :-
    solve(Path),
    Path = [s(0, 0) | _],
    last(Path, s(2, _)),
    length(Path, 7).
