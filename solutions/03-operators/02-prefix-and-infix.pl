% Solution: 02-prefix-and-infix

notation(T, prefix) :- functor(T, _, 1).
notation(T, infix)  :- functor(T, _, 2).

% Do not edit below this line

test :-
    notation(- a, prefix),
    notation(\+ foo, prefix),
    notation(a - b, infix),
    notation(2 + 3, infix).
