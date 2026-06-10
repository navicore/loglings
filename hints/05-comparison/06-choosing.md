# Hint — 06-choosing

Don't guess — run each predicate through the two questions (evaluate?
bind?) and let the grid pick for you:

- **double**: you're handed N and must *produce* D. Producing a value is
  binding; "times two" is evaluating. Which corner does both?
- **balanced**: both sides are already given and may be expressions; you
  only need a yes/no answer. Evaluate both, bind nothing.
- **boxed**: `box(X)` is a structure to assemble, not a sum to compute.
  Bind without evaluating.

If a predicate errors with "evaluable", you tried to evaluate a term
that isn't arithmetic. If it fails on a value that looks correct, you
probably bound a *term* where the test wanted a *number*.
