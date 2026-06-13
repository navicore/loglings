# Hint — 05-traffic

Match each task to the construct whose shape it fits:

- **action**: three outcomes chosen by which light it is — that's the
  if-then-else chain from exercise 02 (`red -> stop ; yellow -> slow ;
  go`).
- **warn**: "red OR yellow" is a disjunction — exercise 01's shape.
- **crossable**: "action is NOT stop" is a negation — put `\+` in front
  of a call to your own `action(Light, stop)`.

The third reuses the first, so get `action/2` right and `crossable` is a
one-liner.
