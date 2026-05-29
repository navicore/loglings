% Solution: 04-arith-equal

same_value(A, B) :- A =:= B.

% Do not edit below this line

test :-
    same_value(5, 5),
    same_value(2 + 3, 5),
    same_value(6 * 7, 40 + 2).
