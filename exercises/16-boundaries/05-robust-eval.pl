% Exercise: a robust evaluator (capstone — exceptions meet boundaries)
%
% This brings the last two chapters together. Evaluating an arbitrary
% expression with `is/2` can go wrong in several distinct ways, and each one
% announces itself with a different `error(Formal, _)` ball:
%
%     1 // 0        -> error(evaluation_error(zero_divisor), _)
%     10 ^ 30       -> error(evaluation_error(int_overflow), _)
%     foo + 1       -> error(type_error(evaluable, _), _)     (foo isn't a number)
%
% These are all CATCHABLE. A single `catch/3` around the evaluation receives
% whichever ball was thrown, and — reading the Formal back out, the way chapter
% 15 taught — you can report exactly which kind of failure it was.
%
% Your task: build `eval(Expr, Result)`.
%   - On success, Result is `ok(Value)` — the computed value, wrapped.
%   - If evaluation throws, Result names the problem: `divide_by_zero`,
%     `overflow`, or `not_evaluable`.
%
% Write the recovery as a small `classify/2` that maps each error shape to its
% name — one clause per shape, matching on the Formal and leaving the culprit
% slot a `_`. Then `eval` is just: catch the evaluation, and on a throw hand the
% ball to `classify`.
%
%   eval(6 + 4, R)    gives R = ok(10)
%   eval(1 // 0, R)   gives R = divide_by_zero
%   eval(10 ^ 30, R)  gives R = overflow
%   eval(foo + 1, R)  gives R = not_evaluable
%
% One last thing, and it's the point of the whole chapter: this net catches
% every error your evaluator can RECOVER from. The one error it can't catch is
% the one from exercise 2 — `resource_error(steps)`. Hand `eval` an expression
% that never terminates and no clause of `classify` will ever run; the step
% limit ends it regardless. That asymmetry is the engine's contract: you can
% recover from a bad computation, never from one that won't stop.
%
% Delete the marker when done.

% I AM NOT DONE

% Define eval/2 and classify/2 here.



% Do not edit below this line

test :-
    eval(6 + 4, R1),
    R1 == ok(10),
    eval(1 // 0, R2),
    R2 == divide_by_zero,
    eval(10 ^ 30, R3),
    R3 == overflow,
    eval(foo + 1, R4),
    R4 == not_evaluable,
    eval(2 * 8, R5),
    R5 == ok(16).
