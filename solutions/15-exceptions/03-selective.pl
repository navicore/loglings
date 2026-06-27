% Solution: 03-selective

guarded(Expr, R) :-
    catch(R is Expr, error(type_error(_, _), _), R = -1).

% Do not edit below this line

test :-
    guarded(3 + 4, A),
    A == 7,
    guarded(foo + 1, B),
    B == -1,
    catch(guarded(1 // 0, _), error(evaluation_error(zero_divisor), _), true).
