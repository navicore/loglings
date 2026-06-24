% Exercise: arithmetic that runs in every direction
%
% `is/2` is a one-way street: it evaluates the right-hand side and binds the
% left. You must know every input. Picture a budget — money you have, money
% you spend, money left over. With `is` you'd need a DIFFERENT formula for
% each thing you might be missing:
%
%     Left   is Budget - Spent.     % how much is left?
%     Spent  is Budget - Left.      % how much did I spend?
%     Budget is Spent  + Left.      % what was the budget?
%
% Three formulas for one fact (`Spent + Left = Budget`), because `is` only
% runs left-to-right. `plus/3` is that one fact as a RELATION — true or false
% about its three arguments whichever one you leave blank, and it fills in the
% blank:
%
%     plus(30, 70, B)     % B = 100   (the budget)
%     plus(30, L, 100)    % L = 70    (what's left)
%     plus(S, 70, 100)    % S = 30    (what was spent)
%
% `succ/2` is the same idea for "the next whole number": `succ(X, Y)` means Y
% is one more than X (both >= 0), and it runs both ways — forward to the next,
% backward to the previous:
%
%     succ(5, N)    % N = 6   (next)
%     succ(P, 6)    % P = 5   (previous)
%
% Your task: define two predicates that inherit this any-direction power.
%   budget_left(Budget, Spent, Left) : Spent + Left = Budget.
%   next_page(Page, Next)            : Next is the page after Page.
%
% Each is a one-line relation — but built on `plus`/`succ` instead of `is`,
% it answers whatever the caller leaves open. `budget_left` alone replaces all
% three formulas above; `next_page` gives you both "next page" and "previous
% page" from a single rule. The test asks each one in every direction — which
% an `is`-based version simply could not pass.
%
% Delete the marker when done.

% I AM NOT DONE

% Define budget_left/3 and next_page/2 here.



% Do not edit below this line

test :-
    budget_left(100, 30, L),
    L == 70,
    budget_left(100, S, 70),
    S == 30,
    budget_left(B, 30, 70),
    B == 100,
    next_page(5, N),
    N == 6,
    next_page(P, 6),
    P == 5.
