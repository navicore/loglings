% Exercise: sum a list
%
% Recursion meets lists. The new piece here is *destructuring* a list
% in a rule head: `[H|T]` matches any non-empty list, binding H to the
% head (first element) and T to the rest.
%
%     first_element([H|_], H).      % match the head, ignore the tail
%
% Your task: define `sum_list(List, Total)` to be true when Total is
% the sum of every number in List. Two clauses:
%
%   - base case: the empty list sums to 0
%   - recursive step: head plus the sum of the tail
%
% Delete the marker when done.

% I AM NOT DONE

% Define sum_list/2 here.



% Do not edit below this line

test :-
    sum_list([], S0), S0 = 0,
    sum_list([42], S1), S1 = 42,
    sum_list([1, 2, 3, 4], S2), S2 = 10,
    sum_list([10, -3, 5], S3), S3 = 12.
