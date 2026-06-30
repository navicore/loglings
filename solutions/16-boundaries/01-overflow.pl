% Solution: 01-overflow

fact(0, 1).
fact(N, F) :- N > 0, N1 is N - 1, fact(N1, F1), F is N * F1.

safe_fact(N, F) :-
    catch(fact(N, F), error(evaluation_error(int_overflow), _), F = too_big).

% Do not edit below this line

test :-
    safe_fact(5, F5),
    F5 =:= 120,
    safe_fact(20, F20),
    F20 =:= 2432902008176640000,
    safe_fact(21, F21),
    F21 == too_big.
