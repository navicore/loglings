% Exercise: sort/2 vs msort/2
%
% The standard order of terms is exactly what Prolog's sorting builtins
% use to put a list in order. There are two, and the difference is one
% word: duplicates.
%
%     msort(List, Sorted)   % orders by standard order, KEEPS duplicates
%     sort(List, Sorted)    % orders by standard order, REMOVES duplicates
%
% Examples:
%
%     msort([3, 1, 2, 1], S).   % S = [1, 1, 2, 3]
%     sort([3, 1, 2, 1], S).    % S = [1, 2, 3]   (one 1)
%
% Because the order is the *standard order of terms*, these sort any
% mixed list — numbers before atoms before compounds — not just numbers.
% And the float-before-equal-integer rule shows through:
%
%     msort([2, 1.0, 1], S).    % S = [1.0, 1, 2]
%
% Your task: define two predicates —
%
%   - `keep_dups(List, Sorted)`:   sort, keeping duplicates  (`msort`)
%   - `unique(List, Sorted)`:      sort, removing duplicates (`sort`)
%
% Delete the marker when done.

% I AM NOT DONE

% Define keep_dups/2 and unique/2 here.



% Do not edit below this line

test :-
    keep_dups([3, 1, 2, 1, 3], S1), S1 == [1, 1, 2, 3, 3],
    unique([3, 1, 2, 1, 3], S2), S2 == [1, 2, 3],
    unique([c, a, b, a], S3), S3 == [a, b, c],
    keep_dups([2, 1.0, 1], S4), S4 == [1.0, 1, 2],
    unique([foo(2), 5, a, foo(1)], S5), S5 == [5, a, foo(1), foo(2)].
