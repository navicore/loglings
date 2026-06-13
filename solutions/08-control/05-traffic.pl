% Solution: 05-traffic

action(Light, A) :-
    ( Light = red    -> A = stop
    ; Light = yellow -> A = slow
    ; A = go
    ).

warn(Light) :- ( Light = red ; Light = yellow ).

crossable(Light) :- \+ action(Light, stop).

% Do not edit below this line

test :-
    action(red, stop),
    action(yellow, slow),
    action(green, go),
    warn(red),
    warn(yellow),
    \+ warn(green),
    crossable(green),
    crossable(yellow),
    \+ crossable(red).
