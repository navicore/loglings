% Exercise: ! (cut — commit and stop backtracking)
%
% Prolog normally explores EVERY way to satisfy a goal. The cut, written
% `!`, says "stop exploring." It always succeeds, and as it does it
% throws away the choice points created since the clause was entered:
%
%   - the predicate's remaining clauses won't be tried, and
%   - the goals to the cut's LEFT won't be retried for another solution.
%
% So `!` commits: "this clause, this set of bindings, is the answer —
% don't look for others."
%
% For example, given `door(front). door(back). door(side).`, the goal
% `door(D)` offers all three on backtracking. Calling it and then cutting
% — `enter(D) :- door(D), !.` — commits to the first: `enter(D)` yields
% only `front`, and backtracking finds nothing more.
%
% Below you have three `candidate` facts. Your task is the same move for
% them: define `pick(X)` true for only the FIRST candidate, by calling
% `candidate(X)` and then cutting. `findall` should then collect a single
% answer, not three.
%
% Delete the marker when done.

% I AM NOT DONE

candidate(alice).
candidate(bob).
candidate(carol).

% Define pick/1 here.



% Do not edit below this line

test :-
    pick(P),
    P == alice,
    findall(X, pick(X), L),
    L == [alice].
