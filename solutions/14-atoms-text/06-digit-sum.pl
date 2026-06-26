% Solution: 06-digit-sum

digit_sum(N, S) :-
    number_codes(N, Codes),
    sum_codes(Codes, S).

sum_codes([], 0).
sum_codes([Code|Codes], S) :-
    V is Code - 48,
    sum_codes(Codes, S0),
    S is S0 + V.

% Do not edit below this line

test :-
    digit_sum(0, A),
    A == 0,
    digit_sum(1234, B),
    B == 10,
    digit_sum(99, C),
    C == 18,
    digit_sum(2026, D),
    D == 10.
