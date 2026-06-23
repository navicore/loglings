% Exercise: asking whether a variable has a value yet
%
% Every test so far ran on data that was already there. But sometimes you
% need to ask a different question FIRST: has this variable been given a
% value at all, or is it still an empty slot? Two builtins answer it:
%
%     var(X)     % true when X is still an unbound variable (no value yet)
%     nonvar(X)  % true when X has been bound to something
%
%     ?- var(X).           % X has no value -> true
%     ?- nonvar(X).        % -> false
%     ?- Y = 5, var(Y).    % Y now has a value -> var fails -> false
%     ?- Y = 5, nonvar(Y). % -> true
%
% Why can't unification answer this? Because unifying with an unbound
% variable always SUCCEEDS and binds it — so `=` can never tell you "this
% was empty," it just fills it in. `var`/`nonvar` only LOOK; they don't bind.
%
% Your task: define `coalesce(In, Default, Out)` — the "or-else" pattern.
% If `In` already has a value, `Out` is that value. If `In` is still an
% unbound variable, `Out` is `Default` instead. (Like SQL's COALESCE, or
% "getOrElse": fall back only when nothing was supplied.)
%
% You might reach for one clause — `coalesce(In, _, In).` — unifying Out
% with In. But if In is unbound that just makes Out unbound too, and you've
% no way to notice you should have used Default. The `var`/`nonvar` split is
% what lets you branch on "was I given a value?". Two clauses, one per case.
%
% Delete the marker when done.

% I AM NOT DONE

% Define coalesce/3 here.



% Do not edit below this line

test :-
    coalesce(5, 0, R1),
    R1 == 5,
    coalesce(hello, def, R2),
    R2 == hello,
    coalesce(X, 99, R3),
    R3 == 99,
    coalesce(Y, fallback, R4),
    R4 == fallback,
    var(Y).
