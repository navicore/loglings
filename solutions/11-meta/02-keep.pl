% Solution: 02-keep

positive(X) :- X > 0.
above(Min, X) :- X > Min.

keep(_, [], []).
keep(Pred, [H | T], Kept) :-
    ( call(Pred, H)
    -> Kept = [H | Rest]
    ;  Kept = Rest
    ),
    keep(Pred, T, Rest).

% Do not edit below this line

test :-
    keep(positive, [1, -2, 3, -4, 5], K1),
    K1 == [1, 3, 5],
    keep(above(3), [1, 4, 2, 5, 3], K2),
    K2 == [4, 5],
    keep(positive, [], E),
    E == [].
