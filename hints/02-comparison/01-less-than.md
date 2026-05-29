# Hint — 01-less-than

A rule with two body goals: first look up the person's age from
`age/2`, then check that age against 13.

## Solution sketch

    kid(P) :- age(P, A), A < 13.
