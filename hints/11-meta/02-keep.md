# Hint — 02-keep

Base case: keeping from the empty list gives the empty list.

Recursive case: test the head with `call`. If it holds, the head belongs
at the front of the result; if not, the result is just whatever you keep
from the tail. Either way you then recurse on the tail to build that "rest"
of the kept list.

The if-then-else picks which of the two shapes the result takes; the
recursive call fills in the rest. Let the result of the recursion be a
variable that both branches refer to.

You don't have to do anything special when `Pred` arrives already carrying
data — `above(3)` rather than a bare `positive`. Write `call(Pred, H)`
once: `call` appends `H` as the LAST argument either way, giving
`positive(H)` in one case and `above(3, H)` in the other. `keep/3` never
has to know which; `call` absorbs the difference. That transparency is the
whole point.
