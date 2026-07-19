# Hint — 01-dfs

Two clauses, one base case and one recursive step — the shape you know from
chapter 6.

The base case: if `Node` IS the `Goal`, you're done; the path is `[Goal]`.

The recursive case: follow an `edge(Node, Next)`, but only if `Next` is NOT
already in `Visited` (`\+ member(Next, Visited)`). Then recurse from `Next`
with `[Next | Visited]` as the new visited list. The path you build is
`[Node | Rest]`, where `Rest` is whatever the recursive call returns.

The wrapper just kicks it off with `[From]` as the starting visited list.
