% Solution: 04-compare

order_of(X, Y, O) :- compare(O, X, Y).

% Do not edit below this line

test :-
    order_of(1, 2, O1), O1 == (<),
    order_of(5, 5, O2), O2 == (=),
    order_of(b, a, O3), O3 == (>),
    order_of(1, foo(x), O4), O4 == (<),
    order_of(foo(x), a, O5), O5 == (>).
