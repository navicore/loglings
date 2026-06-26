% Solution: 05-count-digit

count_digit(N, D, Count) :-
    number_chars(N, Cs),
    count_occ(Cs, D, Count).

count_occ([], _, 0).
count_occ([X|T], D, C) :-
    count_occ(T, D, C0),
    ( X == D -> C is C0 + 1 ; C = C0 ).

% Do not edit below this line

test :-
    count_digit(2020, '0', A),
    A == 2,
    count_digit(2020, '2', B),
    B == 2,
    count_digit(12345, '9', C),
    C == 0,
    count_digit(7, '7', D),
    D == 1,
    count_digit(100, '0', E),
    E == 2.
