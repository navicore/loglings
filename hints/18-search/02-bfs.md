# Hint — 02-bfs

Two clauses, mirroring the recursive shape — but the "agenda" is the frontier
list, not the call stack.

The base case: the front of the frontier is `node(Goal, PathRev)`. You're done;
the answer is `reverse(PathRev, Path)`.

The recursive case: the front is `node(State, PathRev)` with `State` not the
goal. Use `findall(node(N, [N|PathRev]), (edge(State, N), \+ member(N,
PathRev)), Succs)` to collect every successor as a new frontier node (each
carrying its own extended path). Then `append(Rest, Succs, Frontier)` — new
nodes go on the BACK — and recurse on `Frontier`.

The wrapper starts the frontier as a single node: the start state with the
one-element reversed path `[Start]`.
