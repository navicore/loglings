# Hint — 04-once

One goal: wrap the `color(C)` call in `once(...)`. That's the whole
definition — `once` handles the "stop after the first" part for you.

The test's `findall(... first_color ...) == [red]` is the giveaway that
it should yield exactly one answer, not three.
