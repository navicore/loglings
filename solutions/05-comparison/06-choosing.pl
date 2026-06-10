% Solution: 06-choosing

double(N, D) :- D is N * 2.
balanced(L, R) :- L =:= R.
boxed(X, B) :- B = box(X).

% Do not edit below this line

test :-
    double(5, D1), D1 = 10,
    double(0, D2), D2 = 0,
    double(-4, D3), D3 = -8,
    balanced(2 + 3, 5),
    balanced(6 * 7, 40 + 2),
    \+ balanced(2 + 2, 5),
    boxed(apple, B1), B1 = box(apple),
    boxed(7, B2), B2 = box(7).
