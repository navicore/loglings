% Solution: 01-operators-are-terms

decompose(E, Op, L, R) :- E =.. [Op, L, R].

% Do not edit below this line

test :-
    decompose(2 + 3, +, 2, 3),
    decompose(10 * 4, *, 10, 4),
    decompose(a - b, -, a, b).
