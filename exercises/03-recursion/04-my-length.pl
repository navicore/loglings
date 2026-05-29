% Exercise: list length, by hand
%
% The standard library gives you `length/2`, but writing your own is a
% useful drill. The structure is identical to summing a list — each
% recursive step adds 1 instead of the head value.
%
% You won't actually use the head element this time. The underscore
% pattern `_` means "match anything, I don't care":
%
%     mylen([], 0).
%     mylen([_|T], N) :- ...
%
% Delete the marker when done.

% I AM NOT DONE

% Define mylen/2 here.



% Do not edit below this line

test :-
    mylen([], L0), L0 = 0,
    mylen([apple], L1), L1 = 1,
    mylen([a, b, c, d, e], L5), L5 = 5,
    mylen([1, 2, [nested, list], 4], L4), L4 = 4.
