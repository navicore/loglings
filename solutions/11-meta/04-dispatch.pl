% Solution: 04-dispatch

double(N, R) :- R is N * 2.
negate(N, R) :- R is -N.

apply_op(Name, In, Out) :-
    Goal =.. [Name, In, Out],
    call(Goal).

% Do not edit below this line

test :-
    apply_op(double, 5, 10),
    apply_op(negate, 7, -7),
    apply_op(double, 0, 0),
    apply_op(negate, -3, 3).
