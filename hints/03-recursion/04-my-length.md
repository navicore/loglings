# Hint — 04-my-length

The simplest variant of "recurse over a list" — you don't look at the
head's value, just its shape.

## Solution sketch

    mylen([], 0).
    mylen([_|T], N) :-
        mylen(T, N1),
        N is N1 + 1.
