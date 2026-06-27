% Exercise: typed errors as a reporting channel (capstone)
%
% Pulling the chapter together: throw to SIGNAL, with the ball naming exactly
% what happened; catch to RECEIVE, reading that name back out. Used this way a
% thrown ball isn't a crash — it's a message. The deep code says precisely what
% went wrong, and the caller decides what to do about it, the two ends linked
% by the shape of the ball.
%
% You'll build a small validator. `validate/1` checks a value and, on the first
% thing wrong with it, throws a ball that NAMES the problem — different problem,
% different atom:
%
%     not_a_number      the value isn't a number at all
%     negative          it's a number, but below 0
%     too_large         it's a number, but above 150
%
% A value that passes every check throws nothing and simply succeeds. An
% if-then-else chain (chapter 08) is the natural way to test the cases in order
% and stop at the first that applies — recall `number/1` from chapter 12 for
% the is-it-a-number test.
%
% Give that chain a final else branch of `true`. That branch is the path a
% valid value takes, and it's load-bearing: an if-then-else with no else FAILS
% when no condition holds, so without it a perfectly valid value would make
% `validate` fail instead of succeed. `true` is not a boolean — Prolog has no
% boolean type. It's a goal, the one that always succeeds (its opposite is
% `fail`). So `true` here means exactly "all checks passed, do nothing, succeed."
%
% Your task: define both `validate/1` and `check(Value, Result)`. `check` runs
% `validate` under a catch and reports the outcome in Result: the atom `ok` if
% the value is valid, or the problem ball itself if validation threw.
%
%   check(30, R)     gives R = ok
%   check(-5, R)     gives R = negative
%   check(200, R)    gives R = too_large
%   check(foo, R)    gives R = not_a_number
%
% The trick in `check` is to catch with an OPEN catcher — a plain variable —
% so it receives whatever ball was thrown, then hand that same variable back
% as Result. Here catching broadly is right: every ball validate throws is one
% you defined and want to report. (Pair the catch with a goal that sets Result
% to `ok` for the no-throw path.)
%
% Delete the marker when done.

% I AM NOT DONE

% Define validate/1 and check/2 here.



% Do not edit below this line

test :-
    check(30, A),
    A == ok,
    check(-5, B),
    B == negative,
    check(200, C),
    C == too_large,
    check(foo, D),
    D == not_a_number,
    check(0, E),
    E == ok,
    check(150, F),
    F == ok.
