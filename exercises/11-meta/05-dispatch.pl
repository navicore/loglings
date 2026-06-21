% Exercise: dispatch — data deciding which goal runs
%
% Put this chapter's two ideas together. You can BUILD a goal from a
% functor and arguments with `=..`, and you can RUN a goal held in a
% variable with `call`. Chain them, and the program picks at runtime which
% predicate to invoke — from a name it was handed as data:
%
%     % to run a one-argument command whose name is in Cmd:
%     Goal =.. [Cmd, 42],
%     call(Goal).            % with Cmd = show, this runs show(42)
%
% That's dynamic DISPATCH: one rule, different behavior depending on the
% name. (A tiny command interpreter works exactly this way — names like
% `draw` or `erase` arrive as data, each mapped to a predicate.)
%
% Below are two one-in, one-out predicates, `double/2` and `negate/2`.
% Your task: define `apply_op(Name, In, Out)` that runs whichever of them
% `Name` selects, passing `In` and `Out` as its two arguments. Build the
% goal from the name and arguments, then call it.
%
% Delete the marker when done.

% I AM NOT DONE

double(N, R) :- R is N * 2.
negate(N, R) :- R is -N.

% Define apply_op/3 here.



% Do not edit below this line

test :-
    apply_op(double, 5, 10),
    apply_op(negate, 7, -7),
    apply_op(double, 0, 0),
    apply_op(negate, -3, 3).
