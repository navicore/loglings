% Solution: 03-precedence-assoc

answer(X)        :- X is (2 + 3) * 4.
left_grouped(Y)  :- Y is (10 - 3) - 2.
right_grouped(Z) :- Z is 2 ^ (3 ^ 2).

% Do not edit below this line

test :-
    answer(20),
    A is 10 - 3 - 2, left_grouped(Y),  Y =:= A, Y =:= 5,
    B is 2 ^ 3 ^ 2,  right_grouped(Z), Z =:= B, Z =:= 512.
