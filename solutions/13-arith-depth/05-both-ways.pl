% Solution: 05-both-ways

budget_left(Budget, Spent, Left) :- plus(Spent, Left, Budget).
next_page(Page, Next) :- succ(Page, Next).

% Do not edit below this line

test :-
    budget_left(100, 30, L),
    L == 70,
    budget_left(100, S, 70),
    S == 30,
    budget_left(B, 30, 70),
    B == 100,
    next_page(5, N),
    N == 6,
    next_page(P, 6),
    P == 5.
