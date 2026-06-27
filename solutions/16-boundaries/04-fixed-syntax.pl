% Solution: 04-fixed-syntax

build_sum(A, B, Term) :- Term =.. [+, A, B].

eval_sum(A, B, V) :-
    build_sum(A, B, Term),
    V is Term.

% Do not edit below this line

test :-
    build_sum(3, 4, T),
    T == 3 + 4,
    eval_sum(3, 4, V),
    V =:= 7,
    eval_sum(10, 20, W),
    W =:= 30.
