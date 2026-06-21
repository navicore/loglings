% Exercise: transforming every element with a predicate
%
% Forall asked a question; filter chose a sublist; now TRANSFORM. Given a
% predicate that relates an input to an output, apply it down a list:
%
%     apply_each(Op, In, Out)
%
% where Out is In with `Op` applied to every element. (This is the library
% predicate `maplist/3`.) Here `Op` names a two-argument, in-then-out
% predicate, so `call` appends BOTH the element and a fresh variable for
% its result:
%
%     double(X, Y) :- Y is X * 2.
%
%     ?- call(double, 4, R).     % runs double(4, R) -> R = 8
%
% As with the last two, the power is that `apply_each` doesn't know or care
% WHICH operation it runs — double, square, anything shaped (In, Out) — so
% one rule replaces a separate "double every element", "square every
% element", and so on.
%
% Your task: define `apply_each(Op, In, Out)`. Element by element, relate
% each input to its output through `Op`.
%
% Delete the marker when done.

% I AM NOT DONE

double(X, Y) :- Y is X * 2.
square(X, Y) :- Y is X * X.

% Define apply_each/3 here.



% Do not edit below this line

test :-
    apply_each(double, [1, 2, 3], R1),
    R1 == [2, 4, 6],
    apply_each(square, [2, 3, 4], R2),
    R2 == [4, 9, 16],
    apply_each(double, [], E),
    E == [].
