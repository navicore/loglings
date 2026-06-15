# Hint — 04-transparency

One clause, one disjunction. The first branch generates a reading, tests
it (`R > 10`), and then cuts. The second branch is the bare `R = none`
fallback. Wrap the two in `( ... ; ... )`.

You don't filter anything yourself — the cut commits to the first reading
that passes. If `findall` comes back as `[12, none]` instead of `[12]`,
the cut isn't reaching the fallback branch; on plgc a cut inside `;`
reaches the whole clause, so it should drop the `none`.
