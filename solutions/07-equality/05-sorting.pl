% Solution: 05-sorting

keep_dups(List, Sorted) :- msort(List, Sorted).
unique(List, Sorted) :- sort(List, Sorted).

% Do not edit below this line

test :-
    keep_dups([3, 1, 2, 1, 3], S1), S1 == [1, 1, 2, 3, 3],
    unique([3, 1, 2, 1, 3], S2), S2 == [1, 2, 3],
    unique([c, a, b, a], S3), S3 == [a, b, c],
    keep_dups([2, 1.0, 1], S4), S4 == [1.0, 1, 2],
    unique([foo(2), 5, a, foo(1)], S5), S5 == [5, a, foo(1), foo(2)].
