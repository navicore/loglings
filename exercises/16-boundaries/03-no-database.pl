% Exercise: the program can't rewrite itself
%
% In some Prologs you can change the program while it runs: `assertz/1` adds a
% clause to the database, `retract/1` removes one. People reach for them to fake
% a mutable variable — assert a counter, retract and re-assert it to "update".
%
% plgc has no mutable database. It compiles your clauses once, ahead of time,
% and they are fixed for the whole run. `assertz/1` and `retract/1` simply
% aren't defined, so CALLING one is an undefined-procedure error — the
% `existence_error` from chapter 15:
%
%     ?- assertz(seen(x)).
%     error(existence_error(procedure, assertz/1), ...)
%
% (You may also see a harmless "undefined predicate" warning printed alongside
% it — that's the engine narrating, not a second failure.)
%
% This isn't a missing feature to work around; it's how the language here
% thinks. State that changes doesn't live in the database — it lives in
% ARGUMENTS, threaded from one call to the next. Where you wanted a mutable
% counter, you carry an accumulator: a value passed in, updated, passed on,
% until a base case hands back the final result.
%
% Your task: define two predicates.
%
%   no_db(Result) — try `assertz(seen(1))` under a catch. There is no database,
%       so it throws `existence_error`; catch it (match the procedure shape, not
%       the exact name) and let Result be the atom `no_database`.
%
%   running_total(List, Acc, Total) — the assert-free way to "keep a running
%       count". Acc is the total so far; add each element as you walk the list;
%       when the list is empty, Total is whatever Acc has reached.
%
%   no_db(R)                       gives R = no_database
%   running_total([3,4,5], 0, T)   gives T = 12
%   running_total([], 0, T)        gives T = 0
%
% Delete the marker when done.

% I AM NOT DONE

% Define no_db/1 and running_total/3 here.



% Do not edit below this line

test :-
    no_db(R),
    R == no_database,
    running_total([3, 4, 5], 0, T),
    T =:= 12,
    running_total([], 0, Z),
    Z =:= 0,
    running_total([10, 20, 30, 40], 0, B),
    B =:= 100.
