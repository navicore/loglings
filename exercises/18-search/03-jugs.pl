% Exercise: water jugs — a state space made of rules
%
% The BFS from 02-bfs isn't really about graphs. It's a GENERAL search: pop a
% state, generate its successors, repeat until a goal state turns up. It works
% on ANY problem where you can say what a STATE is and what MOVES exist. Here
% the states aren't graph nodes — they're jugs.
%
% The classic puzzle: a 4-litre jug and a 3-litre jug, a tap, and a drain.
% Measure exactly 2 litres into the 4-litre jug. A state is `s(A, B)` — A litres
% in the 4-jug, B litres in the 3-jug. The goal is a PROPERTY, not one fixed
% state: `goal(s(A, _)) :- A =:= 2.` ("2 in the big jug, don't care about the
% small one").
%
% Moves are RULES with preconditions, not edges. Four are given: fill a jug
% (only if not already full — filling a full jug changes nothing) and empty a
% jug (only if it has water). Pouring is the interesting one, and it's your
% task.
%
% Pouring A into B moves as much water as FITS. Two things can happen:
%   - A empties first: all of A pours in. Only possible when A =< (room in B).
%     `s(A, B) → s(0, B + A)`.
%   - B fills up first: only the room pours in. `s(A, B) → s(A - Room, 3)`,
%     where `Room is 3 - B`.
% Each direction (`A` into `B`, and `B` into `A`) needs both clauses. (Mind the
% capacities: B holds 3, A holds 4.) A pour only makes sense when the source
% has water AND the target has room — those are your preconditions.
%
% The solver below is 02-bfs, unchanged except it calls `move/2` and `goal/1`.
% Your task: write the four pour clauses (two per direction) as `move/2`.
%
% Delete the marker when done.

% I AM NOT DONE

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

% Define the four pour clauses here (A into B, and B into A).



% Do not edit below this line

test :-
    solve(Path),
    Path = [s(0, 0) | _],
    last(Path, s(2, _)),
    length(Path, 7).
