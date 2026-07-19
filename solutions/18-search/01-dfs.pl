% Solution: 01-dfs

edge(a, b). edge(a, c).
edge(b, d). edge(d, e).
edge(c, e).
edge(e, a).
edge(e, f).

path(From, To, Path) :- search(From, To, [From], Path).

search(Goal, Goal, _, [Goal]).
search(Node, Goal, Visited, [Node|Rest]) :-
    edge(Node, Next),
    \+ member(Next, Visited),
    search(Next, Goal, [Next|Visited], Rest).

% Do not edit below this line

test :-
    path(a, e, [a, b, d, e]),
    path(b, c, [b, d, e, a, c]),
    \+ path(f, a, _).
