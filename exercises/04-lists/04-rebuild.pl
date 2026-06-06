% Exercise: rebuild
%
% So far the patterns have taken lists apart. The same syntax BUILDS
% lists when it appears where an answer goes. One fact can do both at
% once — destructure one argument, construct another, sharing the
% variables:
%
%     swap_first_two([A, B|T], [B, A|T]).
%
% Read it: the first argument must be a list of at least two elements
% (A, B, then T); the second argument is a NEW list built from the same
% pieces — B first, A second, the tail T reused untouched.
%
%     ?- swap_first_two([1, 2, 3, 4], Out).
%     Out = [2, 1, 3, 4].
%
% No body, no arithmetic — pure unification, in both directions.
%
% Your task: define `swap_first_two(List, Swapped)` as above — true when
% Swapped is List with its first two elements exchanged.
%
% (Yes, the answer is sitting in the prose. The point is to read it
% until it stops looking like magic — this head-builds-the-output move
% is exactly how recursion will grow lists in the next chapters.)
%
% Delete the marker when done.

% I AM NOT DONE

% Define swap_first_two/2 here.



% Do not edit below this line

:- dynamic(swap_first_two/2).
test :-
    swap_first_two([1, 2, 3, 4], S1), S1 = [2, 1, 3, 4],
    swap_first_two([a, b], S2), S2 = [b, a],
    swap_first_two([x, y, z], S3), S3 = [y, x, z],
    \+ swap_first_two([lonely], _),
    \+ swap_first_two([], _).
