% Solution: 03-true-fail

always :- true.

never :- fail.

open(Door) :-
    ( Door == vault -> fail
    ; true
    ).

% Do not edit below this line

test :-
    always,
    \+ never,
    open(front),
    open(side),
    open(garden),
    \+ open(vault).
