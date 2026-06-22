% Exercise: filtering with a predicate you're handed
%
% `all_pass` asked a yes/no question about a list. Now build something:
% `keep(Pred, List, Kept)` — Kept is the elements of List that satisfy
% `Pred`, in order. Same higher-order idea, but it produces a sublist
% instead of a verdict. (This is the library predicate `include/3`.)
%
% This exercise also shows WHY `call` bothers to append arguments. A test
% can carry some of its own data. Define a two-argument predicate and you
% can hand `call` a PARTIAL goal — the predicate with its first argument
% already filled — and `call` supplies the rest:
%
%     above(Min, X) :- X > Min.
%
%     ?- call(above(3), 5).      % above(3) is partial; call appends 5
%                                % -> above(3, 5) -> 5 > 3 -> true
%
% So `above(3)` behaves like a one-argument test "greater than 3", built
% on the fly from data. That is partial application, and it's the whole
% reason `call` takes extra arguments.
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
