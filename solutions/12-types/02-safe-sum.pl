% Solution: 02-safe-sum

sum_nums([], 0).
sum_nums([H | T], S) :-
    sum_nums(T, S0),
    ( number(H) -> S is S0 + H ; S = S0 ).

% Do not edit below this line

test :-
    sum_nums([1, foo, 2, bar, 3], S1),
    S1 == 6,
    sum_nums([apple, banana], S2),
    S2 == 0,
    sum_nums([10, 20, 30], S3),
    S3 == 60,
    sum_nums([], S4),
    S4 == 0.
