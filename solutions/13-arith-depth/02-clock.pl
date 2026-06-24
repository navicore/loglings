% Solution: 02-clock

clock(Start, Delta, Hour) :-
    Raw is Start + Delta,
    Hour is Raw mod 12.

% Do not edit below this line

test :-
    clock(10, 5, H1),
    H1 == 3,
    clock(3, -5, H2),
    H2 == 10,
    clock(0, -1, H3),
    H3 == 11,
    M is -5 mod 12,
    M == 7,
    R is -5 rem 12,
    R == -5,
    D is -5 div 12,
    D == -1.
