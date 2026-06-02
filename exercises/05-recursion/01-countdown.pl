% Exercise: countdown — your first recursive rule
%
% Recursion in Prolog has two pieces:
%   1. A "base case" — the simplest situation, true on its own.
%   2. A "recursive step" — a rule whose body calls the same predicate
%      with a SMALLER input, eventually reaching the base case.
%
% Your task: define `countdown(N)` to be true for every non-negative
% integer N. The base case is when N is 0. The recursive step: if N is
% strictly greater than 0, then countdown(N) holds whenever countdown
% holds for N - 1.
%
% You'll need `is/2` to compute N - 1 and `>/2` to guard the recursion
% — both from the previous sections. The guard MUST come before the
% recursive call, otherwise negative inputs spiral into infinite
% recursion.
%
% Delete the marker when done.

% I AM NOT DONE

% Define countdown/1 here (two clauses: base case + recursive step).



% Do not edit below this line

test :- countdown(5), countdown(0).
