% Solution: 03-sum-list

sum_list([], 0).
sum_list([H|T], S) :-
    sum_list(T, S1),
    S is H + S1.

% Do not edit below this line

test :-
    sum_list([], S0), S0 = 0,
    sum_list([42], S1), S1 = 42,
    sum_list([1, 2, 3, 4], S2), S2 = 10,
    sum_list([10, -3, 5], S3), S3 = 12.
