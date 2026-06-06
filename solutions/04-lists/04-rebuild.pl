% Solution: 04-rebuild

swap_first_two([A, B|T], [B, A|T]).

% Do not edit below this line

:- dynamic(swap_first_two/2).
test :-
    swap_first_two([1, 2, 3, 4], S1), S1 = [2, 1, 3, 4],
    swap_first_two([a, b], S2), S2 = [b, a],
    swap_first_two([x, y, z], S3), S3 = [y, x, z],
    \+ swap_first_two([lonely], _),
    \+ swap_first_two([], _).
