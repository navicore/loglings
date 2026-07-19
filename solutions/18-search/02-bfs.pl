% Solution: 02-bfs

edge(a, b). edge(a, c).
edge(b, d). edge(d, e).
edge(c, e).
edge(e, a).
edge(e, f).

bfs_path(Start, Goal, Path) :- bfs([node(Start, [Start])], Goal, Path).

bfs([node(Goal, PathRev) | _], Goal, Path) :-
    reverse(PathRev, Path).
bfs([node(State, PathRev) | Rest], Goal, Path) :-
    State \= Goal,
    findall(node(N, [N | PathRev]), (edge(State, N), \+ member(N, PathRev)), Succs),
    append(Rest, Succs, Frontier),
    bfs(Frontier, Goal, Path).

% Do not edit below this line

test :-
    bfs_path(a, e, [a, c, e]),
    bfs_path(b, c, [b, d, e, a, c]),
    \+ bfs_path(f, a, _).
