% Solution: 01-head-and-tail

first([H|_], H).
rest([_|T], T).

% Do not edit below this line

:- dynamic(first/2).
:- dynamic(rest/2).
test :-
    first([10, 20, 30], F), F = 10,
    rest([10, 20, 30], R), R = [20, 30],
    first([only], F1), F1 = only,
    rest([only], R1), R1 = [],
    \+ first([], _).
