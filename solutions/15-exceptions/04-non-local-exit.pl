% Solution: 04-non-local-exit

product(List, P) :-
    catch(prod(List, P), zero, P = 0).

prod([], 1).
prod([0|_], _) :-
    throw(zero).
prod([H|T], P) :-
    H =\= 0,
    prod(T, P0),
    P is H * P0.

% Do not edit below this line

test :-
    product([2, 3, 4], A),
    A == 24,
    product([2, 0, 4], B),
    B == 0,
    product([], C),
    C == 1,
    product([5], D),
    D == 5,
    product([7, 0], E),
    E == 0.
