% Exercise: choosing is vs = vs =:=
%
% You've now met all three. They're easy to confuse — each is just an
% operator sitting between two things — but each answers a different
% pair of questions (the grid from the last exercise):
%
%                  | doesn't evaluate   | evaluates arithmetic
%     -------------+--------------------+----------------------
%     binds a var  | =   (unify)        | is  (eval, then bind)
%     just tests   | ==  (identity)     | =:= (eval, then compare)
%
% This time nobody tells you which to use. Each predicate below admits
% exactly ONE of the three — pick wrong and the test fails, or errors.
% Decide each by asking the two questions:
%
%   1. double(N, D): given N, PRODUCE D as N times two.
%      You must evaluate the arithmetic AND bind D.        -> ?
%
%   2. balanced(L, R): true when L and R are equal AS NUMBERS, where
%      either side may be an expression like `2 + 3`.
%      You must evaluate both sides and bind nothing.      -> ?
%
%   3. boxed(X, B): B should be the term  box(X)  — a structure to
%      assemble, not a sum to compute.
%      You must bind B without evaluating anything.        -> ?
%
% Watch for the two ways a wrong pick shows up: an "evaluable" error
% means you tried to evaluate a term that isn't arithmetic; a quiet
% failure on a value that looks right usually means you bound a TERM
% where you wanted a NUMBER.
%
% Delete the marker when done.

% I AM NOT DONE

% double(N, D): D is N times two.
% double(N, D) :- ...

% balanced(L, R): L and R equal as numbers.
% balanced(L, R) :- ...

% boxed(X, B): B is the term box(X).
% boxed(X, B) :- ...



% Do not edit below this line

test :-
    double(5, D1), D1 = 10,
    double(0, D2), D2 = 0,
    double(-4, D3), D3 = -8,
    balanced(2 + 3, 5),
    balanced(6 * 7, 40 + 2),
    \+ balanced(2 + 2, 5),
    boxed(apple, B1), B1 = box(apple),
    boxed(7, B2), B2 = box(7).
