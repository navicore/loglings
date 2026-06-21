% Solution: 01-univ-build

make(Functor, A, B, Term) :- Term =.. [Functor, A, B].

% Do not edit below this line

test :-
    make(point, 3, 4, T1),
    T1 == point(3, 4),
    make(likes, sam, tea, T2),
    T2 == likes(sam, tea),
    make(edge, a, b, T3),
    T3 == edge(a, b).
