% Solution: 03-apply-each

double(X, Y) :- Y is X * 2.
square(X, Y) :- Y is X * X.

apply_each(_, [], []).
apply_each(Op, [H | T], [H2 | T2]) :-
    call(Op, H, H2),
    apply_each(Op, T, T2).

% Do not edit below this line

test :-
    apply_each(double, [1, 2, 3], R1),
    R1 == [2, 4, 6],
    apply_each(square, [2, 3, 4], R2),
    R2 == [4, 9, 16],
    apply_each(double, [], E),
    E == [].
