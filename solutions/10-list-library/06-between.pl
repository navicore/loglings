% Solution: 06-between

even_range(Lo, Hi, L) :-
    findall(X, (between(Lo, Hi, X), 0 is X mod 2), L).

% Do not edit below this line

test :-
    even_range(1, 10, L),
    L == [2, 4, 6, 8, 10],
    even_range(2, 2, One),
    One == [2],
    even_range(3, 3, None),
    None == [].
