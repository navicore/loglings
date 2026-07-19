# Hint — 01-encode

The encoding has two shapes. A bare fact becomes a `clause/2` with `true` as
the second argument — because a fact is a rule that needs nothing else to
hold. A real rule becomes `clause/2` with the body copied verbatim.

For `prove/1`: a goal is a fact if you can find a clause whose **second**
argument is `true`. Use `clause(G, true)` to look for exactly that.
