% Solution: 05-validate

validate(A) :-
    (   \+ number(A) -> throw(not_a_number)
    ;   A < 0        -> throw(negative)
    ;   A > 150      -> throw(too_large)
    ;   true
    ).

check(A, Result) :-
    catch((validate(A), Result = ok), Problem, Result = Problem).

% Do not edit below this line

test :-
    check(30, A),
    A == ok,
    check(-5, B),
    B == negative,
    check(200, C),
    C == too_large,
    check(foo, D),
    D == not_a_number,
    check(0, E),
    E == ok,
    check(150, F),
    F == ok.
