# Hint — 01-bound

Two clauses, one for each case. In the first, `In` is already bound, so the
answer is `In` itself; guard that clause with `nonvar(In)`. In the second,
`In` is still empty, so the answer is `Default`; guard that clause with
`var(In)`.

The guards make the two clauses mutually exclusive — exactly one fires for
any call — so you never have to worry about getting both answers back.
