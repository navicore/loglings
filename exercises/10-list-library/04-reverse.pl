% Exercise: reverse/2 (flip a list end-for-end)
%
% `reverse/2` relates a list to its reversal:
%
%     reverse([a, b, c], R).     % R = [c, b, a]
%
% Straightforward enough. The interesting bit is what you can BUILD from
% it once you stop thinking of reverse as just "give me the backwards
% copy" and start thinking about when a list and its reversal are RELATED
% in a particular way.
%
% Your task: define `palindrome(L)` — true when L reads the same forwards
% and backwards (`[a,b,a]`, `[1,2,2,1]`, the empty list, any single
% element). Don't walk the list by hand — there's a one-line way to say
% "this list IS its own reversal" using `reverse/2`.
%
% Delete the marker when done.

% I AM NOT DONE

% Define palindrome/1 here.



% Do not edit below this line

test :-
    palindrome([a, b, a]),
    palindrome([1, 2, 2, 1]),
    palindrome([x]),
    palindrome([]),
    \+ palindrome([a, b]),
    \+ palindrome([1, 2, 3]).
