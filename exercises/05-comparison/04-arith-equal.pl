% Exercise: =:= (arithmetic equality)
%
% You might expect `=` to test if two numbers are equal. Prolog has a
% different idea: `=` is *unification*, which can bind variables. It
% doesn't evaluate arithmetic at all.
%
%     X = 2 + 3.        % succeeds, binds X to the TERM "2 + 3" (not 5!)
%     5 = 2 + 3.        % FAILS — 5 is not the term "2 + 3"
%
% To compare two arithmetic *values*, use `=:=`. Both sides are
% evaluated first, then compared:
%
%     5 =:= 2 + 3.      % succeeds — both sides evaluate to 5
%     2 * 3 =:= 6.      % succeeds
%     5 =:= 6.          % fails
%
% Here is the whole picture at last. Two independent questions decide
% which operator you want:
%
%   - Does it EVALUATE arithmetic (turn `2 + 3` into `5`)?
%   - Does it BIND a variable (give an unbound variable a value)?
%
%                  | doesn't evaluate   | evaluates arithmetic
%     -------------+--------------------+----------------------
%     binds a var  | =   (unify)        | is  (eval, then bind)
%     just tests   | ==  (identity)     | =:= (eval, then compare)
%
% `is` is the only one that does BOTH. `=:=` evaluates but never binds —
% both sides must already be computable. `=` binds but never evaluates.
% (`==` is the fourth corner — you'll meet it in chapter 07.)
%
% Your task: define `same_value(A, B)` true when A and B are equal as
% *numbers* (after evaluation). Don't use `=` — use `=:=`.
%
% Delete the marker when done.

% I AM NOT DONE

% Define same_value/2 here.



% Do not edit below this line

test :-
    same_value(5, 5),
    same_value(2 + 3, 5),
    same_value(6 * 7, 40 + 2).
