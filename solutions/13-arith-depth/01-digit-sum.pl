% Solution: 01-digit-sum

digit_sum(N, N) :- N < 10.
digit_sum(N, S) :-
    N >= 10,
    Last is N mod 10,
    Rest is N // 10,
    digit_sum(Rest, S0),
    S is S0 + Last.

% Do not edit below this line

test :-
    digit_sum(0, A),
    A == 0,
    digit_sum(7, B),
    B == 7,
    digit_sum(1234, C),
    C == 10,
    digit_sum(99, D),
    D == 18.
