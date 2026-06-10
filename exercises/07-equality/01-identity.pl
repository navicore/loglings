% Exercise: == (term identity)
%
% Back in chapter 05 you met a grid with one empty corner:
%
%                  | doesn't evaluate   | evaluates arithmetic
%     -------------+--------------------+----------------------
%     binds a var  | =   (unify)        | is  (eval, then bind)
%     just tests   | ==  ( <- here )    | =:= (eval, then compare)
%
% `==/2` is that corner: it tests whether two terms are ALREADY the
% identical term — no unification, no binding, no arithmetic. It just
% asks "are these the same term, right now?"
%
%     a == a.            % true
%     foo(1) == foo(1).  % true — same functor, same args
%     X == a.            % FALSE — an unbound variable is not the atom a
%                        %   (`=` would SUCCEED here by binding X to a)
%
% The sharpest contrast is with `=:=`. In the NUMBER world `1` and `1.0`
% are equal; in the TERM world they are different terms:
%
%     1 =:= 1.0.         % true  — equal as numbers
%     1 == 1.0.          % FALSE — an integer term is not a float term
%
% Your task: define `same_term(X, Y)` true when X and Y are the
% identical term. Use `==`.
%
% Delete the marker when done.

% I AM NOT DONE

% Define same_term/2 here.



% Do not edit below this line

test :-
    same_term(a, a),
    same_term(foo(1, b), foo(1, b)),
    \+ same_term(a, b),
    \+ same_term(1, 1.0),
    \+ same_term(_, hello).
