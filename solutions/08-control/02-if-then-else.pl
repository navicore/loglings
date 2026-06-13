% Solution: 02-if-then-else

sign(N, S) :-
    ( N > 0 -> S = positive
    ; N < 0 -> S = negative
    ; S = zero
    ).

% Do not edit below this line

test :-
    sign(5, positive),
    sign(-3, negative),
    sign(0, zero),
    sign(100, positive),
    sign(-1, negative).
