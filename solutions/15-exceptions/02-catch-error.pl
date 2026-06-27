% Solution: 02-catch-error

safe_div(A, B, R) :-
    catch(R is A // B, error(evaluation_error(zero_divisor), _), R = 0).

% Do not edit below this line

test :-
    safe_div(10, 2, A),
    A == 5,
    safe_div(7, 0, B),
    B == 0,
    safe_div(0, 5, C),
    C == 0,
    safe_div(-9, 3, D),
    D == -3.
