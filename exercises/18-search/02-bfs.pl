% Exercise: breadth-first search — the frontier is data
%
% 01-dfs searched by recursion: the "where to explore next" lived on the call
% stack, so it dove deep before ever looking wide. Depth-first search finds A
% path, but not the SHORTEST one. In the graph below, DFS from `a` finds
% `a → b → d → e` (three hops) — yet `a → c → e` (two hops) is shorter.
%
% Breadth-first search explores level by level — everything one hop away, then
% everything two hops away — so the FIRST path it finds to the goal is a
% shortest one. And it does it without recursion: the "where to explore next"
% lives in a DATA structure called the FRONTIER, a queue of nodes waiting to be
% expanded. Search moves from the call stack into a list you hold.
%
% Each frontier entry is a `node(State, Path)` — a state plus the path that
% reached it (start-to-goal, the same order 01-dfs produced). The loop:
%   - pop the FRONT entry; if its State is the Goal, its Path is the answer;
%   - otherwise generate its successors with `findall/3` (chapter 00/08) —
%     every edge out, to a state not already on its own path — and APPEND them
%     to the BACK of the frontier (that's what makes it a queue).
%
% Watch it find the shortest path to `e`. New nodes go on the back, so the
% two-hop path is reached before the three-hop one:
%
%     frontier = [node(a, [a])]
%       pop a → successors b, c   →  [node(b, [a,b]), node(c, [a,c])]
%       pop b → successor d       →  [node(c, [a,c]), node(d, [a,b,d])]
%       pop c → successor e       →  [node(d, [a,b,d]), node(e, [a,c,e])]
%       pop d → successor e       →  [node(e, [a,c,e]), node(e, [a,b,d,e])]
%       pop e → e is the goal  →  Path = [a, c, e]
%
% The `e` reached via `c` was queued earlier (level two) than the `e` via `d`
% (level three), so it's popped first — breadth-first finds shortest.
% (Append-to-back is BFS; append-to-front would be DFS — the whole difference
% between the two strategies is that one `append`.)
%
% Your task: write `bfs(Frontier, Goal, Path)` and the wrapper
% `bfs_path(Start, Goal, Path) :- bfs([node(Start, [Start])], Goal, Path).`
% `append/3` and `findall/3` are the stdlib.
%
% Delete the marker when done.

% I AM NOT DONE

edge(a, b). edge(a, c).
edge(b, d). edge(d, e).
edge(c, e).
edge(e, a).
edge(e, f).

% Define bfs/3 and bfs_path/3 here.



% Do not edit below this line

test :-
    bfs_path(a, e, [a, c, e]),
    bfs_path(b, c, [b, d, e, a, c]),
    \+ bfs_path(f, a, _).
