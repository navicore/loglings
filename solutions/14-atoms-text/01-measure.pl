% Solution: 01-measure

total_length([], 0).
total_length([A|As], N) :-
    atom_length(A, L),
    total_length(As, N0),
    N is N0 + L.

% Do not edit below this line

test :-
    total_length([], A),
    A == 0,
    total_length([hello], B),
    B == 5,
    total_length([cat, dog, fish], C),
    C == 10,
    total_length([a, bb, ccc], D),
    D == 6.
