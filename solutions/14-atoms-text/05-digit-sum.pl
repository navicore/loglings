% Solution: 05-digit-sum

digit_sum_chars(N, S) :-
    number_chars(N, Cs),
    sum_chars(Cs, S).

sum_chars([], 0).
sum_chars([C|Cs], S) :-
    number_chars(V, [C]),
    sum_chars(Cs, S0),
    S is S0 + V.

digit_sum_codes(N, S) :-
    number_codes(N, Codes),
    sum_codes(Codes, S).

sum_codes([], 0).
sum_codes([Code|Codes], S) :-
    V is Code - 48,
    sum_codes(Codes, S0),
    S is S0 + V.

% Do not edit below this line

test :-
    digit_sum_chars(0, A),
    A == 0,
    digit_sum_chars(1234, B),
    B == 10,
    digit_sum_codes(1234, C),
    C == 10,
    digit_sum_codes(99, D),
    D == 18,
    digit_sum_chars(2026, E),
    digit_sum_codes(2026, F),
    E == F,
    E == 10.
