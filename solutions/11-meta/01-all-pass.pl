% Solution: 01-all-pass

positive(X) :- X > 0.
even(X) :- 0 is X mod 2.

all_pass(_, []).
all_pass(Pred, [H | T]) :-
    call(Pred, H),
    all_pass(Pred, T).

% Do not edit below this line

test :-
    all_pass(positive, [3, 5, 9]),
    all_pass(even, [2, 4, 6]),
    all_pass(positive, []),
    \+ all_pass(positive, [3, -1, 9]),
    \+ all_pass(even, [2, 5, 6]).
