% Solution: 02-bfs

edge(a, b). edge(a, c).
edge(b, d). edge(d, e).
edge(c, e).
edge(e, a).
edge(e, f).

bfs_path(Start, Goal, Path) :- bfs([node(Start, [Start])], Goal, Path).

bfs([node(Goal, Path) | _], Goal, Path).
bfs([node(State, Path) | Rest], Goal, Sol) :-
    State \= Goal,
    findall(node(N, NP), (edge(State, N), \+ member(N, Path), append(Path, [N], NP)), Succs),
    append(Rest, Succs, Frontier),
    bfs(Frontier, Goal, Sol).

% Do not edit below this line

test :-
    bfs_path(a, e, [a, c, e]),
    bfs_path(b, c, [b, d, e, a, c]),
    \+ bfs_path(f, a, _).
