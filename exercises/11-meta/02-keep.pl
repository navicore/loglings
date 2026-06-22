% Exercise: filtering with a predicate you're handed
%
% `all_pass` asked a yes/no question about a list. Now build something:
% `keep(Pred, List, Kept)` — Kept is the elements of List that satisfy
% `Pred`, in order. Same higher-order idea, but it produces a sublist
% instead of a verdict. (This is the library predicate `include/3`.)
%
% This exercise also shows WHY `call` bothers to append arguments. It turns
% on one rule worth saying out loud:
%
%     call ALWAYS appends its extra arguments to the END of the goal.
%
% That rule explains the two test predicates below, which look mismatched at
% first: `positive` takes ONE argument, `above` takes TWO. How can `keep`
% use both the same way?
%
%     positive(X)    :- X > 0.       % the element is the only argument
%     above(Min, X)  :- X > Min.     % the element is the LAST argument
%
% `keep` runs each test as `call(Pred, H)`, appending the element H last.
% For `positive` that builds `positive(H)`. For `above(3)` — that's `above`
% with its first slot already filled by data — it builds `above(3, H)`.
% Both land H in the last position, which is exactly where each predicate
% expects the value to test:
%
%     call(positive,  5)  ->  positive(5)  ->  5 > 0  ->  true
%     call(above(3),  5)  ->  above(3, 5)  ->  5 > 3  ->  true
%
% So `Min` is `above`'s FIRST argument on purpose. The data you fix ahead of
% time goes first; the per-element value `call` supplies goes last. That's
% why `above(3)` works as a ready-made test "greater than 3" — it carries
% the floor and leaves the last slot open for `call` to fill. Put fixed data
% first and the varying value last, and one `keep` works with any test.
%
% Your task: define `keep(Pred, List, Kept)`. Walk the list; keep each
% element for which `Pred` holds, drop the rest. (An if-then-else inside
% the recursive clause decides keep-or-drop.)
%
% Delete the marker when done.

% I AM NOT DONE

positive(X) :- X > 0.
above(Min, X) :- X > Min.

% Define keep/3 here.



% Do not edit below this line

test :-
    keep(positive, [1, -2, 3, -4, 5], K1),
    K1 == [1, 3, 5],
    keep(above(3), [1, 4, 2, 5, 3], K2),
    K2 == [4, 5],
    keep(positive, [], E),
    E == [].
