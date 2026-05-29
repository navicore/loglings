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
% Your task: define a rule `answer(X)` that uses `is/2` to bind X to
% the sum of 100 and 23.
%
% Delete the marker when done.

% I AM NOT DONE

% Define answer/1 here.



% Do not edit below this line

test :- answer(X), X = 123.
