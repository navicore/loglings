% Exercise: transforming a term with =..
%
% Because `=..` reads both ways, you can take a term apart and put a
% DIFFERENT one back together. Splitting gives you `[Functor | Args]`; keep
% the args but swap the functor, and you've relabeled the term:
%
%     ?- weight(70) =.. [_ | Args].
%     Args = [70].
%     ?- Result =.. [mass | [70]].
%     Result = mass(70).
%
% Same arguments, new name. The underscore on the way in throws the old
% functor away; `Args` carries the rest across to the rebuild.
%
% Your task: define `retag(Term, NewName, Result)` so that Result has the
% functor `NewName` but the SAME arguments as Term — whatever Term's arity
% happens to be.
%
% Delete the marker when done.

% I AM NOT DONE

% Define retag/3 here.



% Do not edit below this line

test :-
    retag(point(3, 4), vector, R1),
    R1 == vector(3, 4),
    retag(node(a, b, c), leaf, R2),
    R2 == leaf(a, b, c),
    retag(foo(1), bar, R3),
    R3 == bar(1).
