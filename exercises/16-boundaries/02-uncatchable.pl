% Exercise: the error you cannot catch
%
% Last exercise, `int_overflow` was catchable — so was every error in chapter
% 15. It would be easy to conclude `catch/3` is a universal safety net. It
% isn't, and this is the one exception that matters most.
%
% plgc runs every query under a STEP LIMIT: a cap on how much work a single
% goal may do (10000 steps). A computation that never finishes — usually a
% recursion with no reachable base case — hits that cap and the engine stops it
% with `error(resource_error(steps), ...)`. The crucial part: this error is
% NOT catchable. A `catch/3` wrapped around a runaway goal does not recover —
% the query just terminates (the runner reports it as a runtime error, exit 3):
%
%     loop :- loop.
%     ?- catch(loop, _, recovered).      % does NOT print recovered — it dies
%
% Why? Catching is for errors a program can sensibly RECOVER from. A goal that
% won't terminate isn't a recoverable condition — it's a bug in your logic, and
% no amount of error handling fixes it. The step limit is a guard rail, not a
% signal. So termination is YOUR responsibility: it has to be designed in, with
% a base case the recursion actually reaches. There is no catch to fall back on.
%
% Below is the recursive clause of `countup(Current, Target)` — it counts
% Current upward until it meets Target. As written it has no base case, so it
% can never stop: `countup(0, 3)` would climb 0, 1, 2, 3, 4, ... past the target
% forever and trip the uncatchable step limit.
%
% Your task: add the ONE base-case clause that lets it terminate — when Current
% has reached Target, succeed. With that clause in place the count stops exactly
% on Target and stays well within the step budget.
%
%   countup(0, 5)   succeeds        countup(3, 3)   succeeds
%   countup(5, 2)   fails (cleanly — Current already past Target, no runaway)
%
% Delete the marker when done.

% I AM NOT DONE

% Add the base case for countup/2 above this recursive clause.

countup(Current, Target) :-
    Current < Target,
    Next is Current + 1,
    countup(Next, Target).

% Do not edit below this line

test :-
    countup(0, 5),
    countup(3, 3),
    \+ countup(5, 2).
