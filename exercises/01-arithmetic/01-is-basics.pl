% Exercise: is/2 and addition
%
% So far you've worked with atoms (lowercase names) and lists. Now you
% need to compute with numbers — and Prolog has a small surprise about
% how that works.
%
% Writing `X + 2` in a goal does NOT compute anything. It just builds a
% term shaped like a plus expression. To actually evaluate it, use the
% `is/2` operator:
%
%     X is 2 + 3.    % evaluates 2 + 3 and binds X to 5
%     Y is 10 + 7.   % evaluates 10 + 7 and binds Y to 17
%
% The right-hand side must be fully ground (all variables bound to
% numbers) — `is/2` is the bridge between Prolog terms and arithmetic.
%
% Heads-up for later: `is` is one of a trio that look alike but differ
% on two axes — does the operator *evaluate* arithmetic, and does it
% *bind* a variable? `is` does BOTH: it evaluates the right side and
% binds the left. You'll soon meet `=` (binds, never evaluates) and
% `=:=` (evaluates, never binds); chapter 05 lays all three out in one
% grid. For now: reach for `is` whenever you need a computed number.
%
% Your task: define a rule `answer(X)` that uses `is/2` to bind X to
% the sum of 100 and 23.
%
% Delete the marker when done.

% I AM NOT DONE

% Define answer/1 here.



% Do not edit below this line

test :- answer(X), X = 123.
