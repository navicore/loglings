# Hint — 05-validate

Two predicates working as a pair.

**`validate/1`** tests the value and throws on the first thing wrong. An
if-then-else chain checks the cases in order: is it not a number? then is it
below 0? then is it above 150? The first test that holds throws the matching
atom; if none hold, control reaches the final else branch. Make that branch
`true` — the goal that always succeeds (Prolog has no boolean type; `true` and
`fail` are goals, not values). It's not optional decoration: an if-then-else
with no else *fails* when nothing matches, so without it a valid value would
make `validate` fail instead of succeed. Reach for `number/1` for the first
test, and `<` / `>` for the bounds.

**`check/2`** wraps `validate` in a `catch`. Two things have to happen for the
no-throw path: validate runs *and* Result becomes `ok` — so the catch's Goal
is both of those together. For the catcher, you want to receive *any* ball
validate might throw, so make it an open variable rather than a fixed shape;
then the recovery's job is simply to pass that caught ball out as Result. Here
the wide-open catcher is the right call — every ball is one you defined and
mean to report — which is the opposite of the narrow catchers exercises 2 and
3 wanted.
