% Exercise: ( Cond -> Then ; Else )  (if-then-else)
%
% Pair `->` with `;` and you get Prolog's conditional:
%
%     ( Cond -> Then ; Else )
%
% Read it: prove Cond; if it succeeds, commit to it and prove Then;
% otherwise prove Else. The `->` *commits* — once Cond succeeds, Prolog
% never backtracks into it to try another solution, and never runs Else.
%
%     classify(N, R) :- ( N >= 0 -> R = nonneg ; R = negative ).
%
% You can CHAIN them for more than two cases, by putting another
% if-then-else in the Else position:
%
%     ( CondA -> ResultA
%     ; CondB -> ResultB
%     ; Default
%     )
%
% Prolog tries each Cond in turn and commits to the first that succeeds;
% the bare last goal is the fall-through when none matched.
%
% Your task: define `sign(N, S)` so that S is:
%   - `positive` when N > 0
%   - `negative` when N < 0
%   - `zero`     otherwise
% Use a chained if-then-else (no separate clauses).
%
% Delete the marker when done.

% I AM NOT DONE

% Define sign/2 here.



% Do not edit below this line

test :-
    sign(5, positive),
    sign(-3, negative),
    sign(0, zero),
    sign(100, positive),
    sign(-1, negative).
