% Solution: 04-kind

kind(T, K) :-
    ( number(T)   -> K = number
    ; atom(T)     -> K = atom
    ; is_list(T)  -> K = list
    ; compound(T) -> K = compound
    ).

% Do not edit below this line

test :-
    kind(42, K1),
    K1 == number,
    kind(3.5, K2),
    K2 == number,
    kind(hello, K3),
    K3 == atom,
    kind([a, b, c], K4),
    K4 == list,
    kind(point(1, 2), K5),
    K5 == compound,
    kind([], K6),
    K6 == atom.
