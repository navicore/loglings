# Hint — 05-grade

Four clauses, top to bottom, highest threshold first:

- `a` clause: guard `Score >= 90`, then `!`.
- `b` clause: guard `Score >= 80`, then `!`.
- `c` clause: guard `Score >= 70`, then `!`.
- `f` clause: no guard, no cut — the catch-all.

Each guard only needs its OWN threshold, not a range: because the cut in
the clause above already committed, by the time control reaches the `b`
clause you know the score was under 90. The `findall(... grade(85,G)...)
== [b]` check is verifying the cuts make it commit to a single letter.
