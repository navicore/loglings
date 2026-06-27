# Hint — 02-uncatchable

You need one fact: the clause that says "when Current has already reached
Target, stop and succeed." It takes no recursive call and no arithmetic — it's
the case where there's nothing left to count. Think about what Current and
Target look like at the moment the count is done, and write the head that
unifies exactly then.

With that base case present, `countup(0, 5)` walks 0, 1, 2, 3, 4, 5 and stops
the instant it matches; `countup(5, 2)` fails cleanly because neither clause
applies (the base needs the two equal, the recursive clause needs `Current <
Target`). Nothing runs away, so the step limit never comes near.

This whole exercise is the lesson that you cannot `catch/3` your way out of a
missing base case — the engine's step limit is uncatchable, so termination has
to be built in. Getting this one fact right *is* that safety.
