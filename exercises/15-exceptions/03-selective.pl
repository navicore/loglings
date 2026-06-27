% Exercise: catch selectively, let the rest through
%
% The Catcher in `catch/3` is matched by UNIFICATION, and that's a feature, not
% a detail. A narrow catcher catches only the balls that fit its shape; every
% other ball sails straight past, on up to the next catch — or out of the
% program if there isn't one. This is how you handle the errors you expect
% while letting the ones you didn't expect stay loud.
%
% Compare the two extremes:
%
%     catch(Goal, error(evaluation_error(zero_divisor), _), R = 0)
%         catches ONLY division by zero. A type error from Goal is not caught.
%
%     catch(Goal, _, R = 0)
%         catches ANY ball at all. This is usually too greedy — it swallows
%         programmer mistakes (an undefined predicate, an unbound variable)
%         and quietly turns them into 0, hiding the bug.
%
% A ball that no catcher matches is RE-THROWN: it keeps travelling outward. So
% you can wrap a narrow catch inside a wider one, and each handles its own kind.
%
% Your task: define `guarded(Expr, R)` — R is the value of arithmetic Expr,
% except that a TYPE error (a non-arithmetic term like `foo` in the
% expression) is recovered to `R = -1`. A zero-divisor error is NOT yours to
% handle here — let it propagate.
%
%   guarded(3 + 4, R)     gives R = 7      (no error)
%   guarded(foo + 1, R)   gives R = -1     (type error, caught)
%   guarded(1 // 0, R)    throws on out    (zero_divisor, NOT caught)
%
% Catch the type error by its Formal shape — `type_error(_, _)` matches any
% type error and ignores which type and which culprit. Because that catcher
% does NOT match `evaluation_error(zero_divisor)`, a divide-by-zero passes
% through untouched. The test below proves both halves: it recovers the type
% error, and it confirms the zero-divisor escapes `guarded` by catching it
% one level out.
%
% Delete the marker when done.

% I AM NOT DONE

% Define guarded/2 here.



% Do not edit below this line

test :-
    guarded(3 + 4, A),
    A == 7,
    guarded(foo + 1, B),
    B == -1,
    catch(guarded(1 // 0, _), error(evaluation_error(zero_divisor), _), true).
