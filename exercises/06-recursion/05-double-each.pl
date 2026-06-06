% Exercise: double each element of a list
%
% Until now your recursive predicates have computed a single number.
% This time the result is a *list* — you have to build it as you go.
%
% Define `double_each(Input, Output)` to be true when Output is the
% list of each Input element multiplied by 2:
%
%     double_each([1, 2, 3], [2, 4, 6]).
%
% The trick: the recursive step's HEAD already builds the output cons
% cell — the same heads-build-too move as `swap_first_two` in chapter
% 04, now applied at every step. Two clauses:
%
%     double_each([], []).
%     double_each([H|T], [H2|T2]) :-
%         H2 is H * 2,
%         double_each(T, T2).
%
% Read the second clause carefully — H2 and T2 appear in the head's
% second argument before they're known. Prolog will fill them in via
% the body's goals. This is the leap from "return a number" to "build
% a structured result."
%
% Delete the marker when done.

% I AM NOT DONE

% Define double_each/2 here.



% Do not edit below this line

test :-
    double_each([], R0), R0 = [],
    double_each([7], R1), R1 = [14],
    double_each([1, 2, 3, 4], R2), R2 = [2, 4, 6, 8],
    double_each([0, -5, 10], R3), R3 = [0, -10, 20].
