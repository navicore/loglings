% Solution: 05-robust-eval

eval(Expr, Result) :-
    catch(( Value is Expr, Result = ok(Value) ), Error, classify(Error, Result)).

classify(error(evaluation_error(zero_divisor), _), divide_by_zero).
classify(error(evaluation_error(int_overflow), _), overflow).
classify(error(type_error(evaluable, _), _), not_evaluable).

% Do not edit below this line

test :-
    eval(6 + 4, R1),
    R1 == ok(10),
    eval(1 // 0, R2),
    R2 == divide_by_zero,
    eval(10 ^ 30, R3),
    R3 == overflow,
    eval(foo + 1, R4),
    R4 == not_evaluable,
    eval(2 * 8, R5),
    R5 == ok(16).
