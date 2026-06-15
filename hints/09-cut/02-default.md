# Hint — 02-default

Two clauses. The first looks the user up — `role(User, Level)` — and then
cuts, so a real match commits. The second is the bare catch-all:
`access(_, none).`

Mind the order: the lookup-and-cut clause must come FIRST, the `none`
default LAST. If `findall(A, access(admin, A), L)` comes back as
`[full, none]` instead of `[full]`, your cut is missing — the default is
leaking through on backtracking.
