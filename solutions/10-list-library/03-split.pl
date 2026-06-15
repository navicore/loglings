% Solution: 03-split

starts_with(List, Prefix) :- append(Prefix, _, List).

% Do not edit below this line

test :-
    starts_with([1, 2, 3, 4], [1, 2]),
    starts_with([a, b], [a, b]),
    starts_with([x, y, z], []),
    \+ starts_with([1, 2, 3], [2, 3]),
    \+ starts_with([1], [1, 2]).
