% Solution: 02-variables-unify

as_term(2 + 3).

% Do not edit below this line

:- dynamic(as_term/1).
test :- as_term(T), T = 2 + 3, \+ ( T = 5 ).
