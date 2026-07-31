# Hint — 02-bfs

Two clauses, one per thing the loop can meet — the trace in the comment shows
exactly what each handles.

The base case: the FRONT of the frontier is `node(Goal, Path)`. Its State is
the goal, so its `Path` is the answer. One clause, no body.

The recursive case: the front is `node(State, Path)` with `State` not the goal.
Collect every successor as a new frontier node with
`findall(node(N, NP), (edge(State, N), \+ member(N, Path), append(Path, [N],
NP)), Succs)` — each new node carries the old path plus its own state appended.
Then `append(Rest, Succs, Frontier)` — new nodes go on the BACK — and recurse
on `Frontier`.

The wrapper starts the frontier as a single node: the start state with the
one-element path `[Start]`.
