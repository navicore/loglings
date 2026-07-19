% Exercise: depth-first search, with a visited list
%
% You already know how to search a graph by recursion: follow an edge, then
% search from where it lands. But there's a trap. Given a graph with a CYCLE —
% a way to get back to where you started — the naive recursion runs forever:
%
%     path(X, Y) :- edge(X, Y).
%     path(X, Y) :- edge(X, Z), path(Z, Y).    % loops on a->b->d->e->a->b->...
%
% Ask it for a path in the graph below and it chases `a → b → d → e → a → …`
% without end. The fix is a VISITED LIST: remember where you've been, and never
% step somewhere already on it. The same idea that keeps a maze-solver from
% walking in circles.
%
% The graph (a cycle, and a dead end):
%
%     a → b   a → c
%     b → d   d → e
%     c → e
%     e → a        ← the cycle back
%     e → f        ← f is a dead end (nothing leaves it)
%
% Your task: write `search(Node, Goal, Visited, Path)` — depth-first search
% that succeeds when Node can reach Goal, binding Path to the route (a list of
% nodes from Node to Goal). Two clauses:
%   - if you're AT the goal, the path is just `[Goal]`;
%   - otherwise follow an edge to a Next you've NOT visited, and recurse with
%     Next added to Visited.
% `member/2` (the stdlib, chapter 10) tests list membership.
%
% A wrapper seeds the visited list with the start node — write it too:
%   `path(From, To, Path) :- search(From, To, [From], Path).`
%
% Delete the marker when done.

% I AM NOT DONE

edge(a, b). edge(a, c).
edge(b, d). edge(d, e).
edge(c, e).
edge(e, a).
edge(e, f).

% Define path/3 (wrapper) and search/4 here.



% Do not edit below this line

test :-
    path(a, e, [a, b, d, e]),
    path(b, c, [b, d, e, a, c]),
    \+ path(f, a, _).
