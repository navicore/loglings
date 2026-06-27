% Exercise: throw your way out of deep work
%
% `throw/1` isn't only for errors. It's also a way to LEAVE — to abandon a
% computation the instant you know the rest of it is pointless, no matter how
% deep in recursion you are. A thrown ball doesn't unwind one step at a time;
% it jumps straight to the matching catch, discarding every pending goal on
% the way. That's a "non-local exit", and some answers are far easier to reach
% with one than without.
%
% Take multiplying a list of numbers. The moment you hit a 0, the whole
% product is 0 — there's no point multiplying the rest. But ordinary recursion
% is committed: it has to return from the deep calls before the top can finish,
% so each pending `* ` still happens on the way back up. A throw skips all of
% that. Deep in the recursion, the clause that meets a 0 just throws; the catch
% up top turns that into the answer 0 directly.
%
% Your task: define `product(List, P)` — P is the product of the numbers in
% List, with `product([], P)` giving `P = 1` (the empty product). Use a throw
% to short-circuit to 0 as soon as a 0 appears.
%
%   product([2, 3, 4], P)    gives P = 24
%   product([2, 0, 4], P)    gives P = 0    (and never multiplies the 4)
%   product([], P)           gives P = 1
%
% The shape: `product` wraps a `catch` whose recovery sets P to 0. The work is
% a small recursive helper that walks the list and multiplies — your sum-a-list
% shape from chapter 06, but with `*` and a base case of 1. Give that helper a
% clause that fires when the head is 0 and `throw`s a ball of your choosing
% (any atom will do) instead of recursing. The other recursive clause handles
% non-zero heads; guard it so it doesn't also match 0. Catch that same ball up
% in `product` and recover P to 0.
%
% Delete the marker when done.

% I AM NOT DONE

% Define product/2 here (plus the helper it needs).



% Do not edit below this line

test :-
    product([2, 3, 4], A),
    A == 24,
    product([2, 0, 4], B),
    B == 0,
    product([], C),
    C == 1,
    product([5], D),
    D == 5,
    product([7, 0], E),
    E == 0.
