% Exercise: building terms with =.. (univ)
%
% Back in the operators chapter you used `=..` to take a term APART:
%
%     ?- (2 + 3) =.. L.
%     L = [+, 2, 3].
%
% It runs the other way too. Give `=..` a list of `[Functor | Args]` and
% it BUILDS the term:
%
%     ?- T =.. [greet, world].
%     T = greet(world).
%
% Why bother, when you could just write `greet(world)` directly? Because
% the functor can be a VARIABLE — something Prolog won't let you write by
% hand. You cannot write `F(world)`, but you CAN write:
%
%     ?- F = greet, T =.. [F, world].
%     T = greet(world).
%
% That's the power: the SHAPE of a term can be decided at runtime, from
% data. Your task: define `make(Functor, A, B, Term)` so that Term is the
% two-argument compound with that functor and those two arguments.
%
% Delete the marker when done.

% I AM NOT DONE

% Define make/4 here.



% Do not edit below this line

test :-
    make(point, 3, 4, T1),
    T1 == point(3, 4),
    make(likes, sam, tea, T2),
    T2 == likes(sam, tea),
    make(edge, a, b, T3),
    T3 == edge(a, b).
