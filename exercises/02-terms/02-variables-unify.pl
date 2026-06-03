% Exercise: variables and unification
%
% A name starting with an UPPERCASE letter (or `_`) is a VARIABLE — a
% placeholder for some term yet to be determined.
%
% The `=` operator is UNIFICATION: it makes its two sides match, binding
% any variables along the way. It matches *structure* — it never runs
% arithmetic:
%
%     X = apple.        % binds X to the atom `apple`
%     foo(X) = foo(bar). % binds X to `bar`
%     X = 2 + 3.        % binds X to the TERM `2 + 3` — NOT the number 5
%
% That last line is the one to sit with: `2 + 3` is a *term* (a shape),
% and `=` captures the shape as-is. The shape `2 + 3` is not equal to the
% number `5`, so `2 + 3 = 5` fails.
%
% Your task: define `as_term/1` so that its argument is the unevaluated
% term `2 + 3`. (A single fact is enough.)
%
% Delete the marker when done.

% I AM NOT DONE

% Define as_term/1 here.



% Do not edit below this line

:- dynamic(as_term/1).
test :- as_term(T), T = 2 + 3, \+ ( T = 5 ).
