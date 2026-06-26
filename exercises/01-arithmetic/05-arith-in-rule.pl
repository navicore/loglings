% Exercise: arithmetic inside a rule
%
% Each previous exercise had ONE input baked into the rule body. Real
% rules take inputs as arguments and compute results.
%
% Pattern:
%
%     double(N, R) :- R is N * 2.
%
% The first argument is the input; the second is the result computed
% with `is/2`. Calling `double(7, X)` binds X to 14.
%
% Worth filing away for later: `is/2` evaluates its right-hand side the
% moment the goal runs, so everything on that side must already be known.
% Here that's automatic — N arrives as an input. But once a rule body has
% several goals, it means the goal that computes a value has to come BEFORE
% the goal that uses it.
%
% Your task: define `square(N, Sq)` so that Sq is N times N.
%
% Delete the marker when done.

% I AM NOT DONE

% Define square/2 here.



% Do not edit below this line

test :-
    square(5, A),  A = 25,
    square(9, B),  B = 81,
    square(12, C), C = 144.
