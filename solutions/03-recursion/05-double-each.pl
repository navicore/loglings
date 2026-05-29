% Solution: 05-double-each

double_each([], []).
double_each([H|T], [H2|T2]) :-
    H2 is H * 2,
    double_each(T, T2).

% Do not edit below this line

test :-
    double_each([], R0), R0 = [],
    double_each([7], R1), R1 = [14],
    double_each([1, 2, 3, 4], R2), R2 = [2, 4, 6, 8],
    double_each([0, -5, 10], R3), R3 = [0, -10, 20].
