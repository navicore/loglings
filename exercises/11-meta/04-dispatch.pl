% Exercise: dispatch — when the predicate's NAME is data
%
% So far the predicate arrived whole, ready for `call`. But sometimes you
% only have its NAME — a plain atom like `double`, perhaps read from a
% command, a config line, or a list of steps. You can't write
% `Name(In, Out)` in Prolog. You assemble the goal with `=..`, which builds
% a term from a list of `[Functor | Args]`, then run it with `call`:
%
%     Goal =.. [Name, In, Out],   % Name = double  ->  Goal = double(In, Out)
%     call(Goal).
%
% Why is this worth it? Without it, routing a name to a predicate means one
% clause per name — a table you grow by hand:
%
%     run(double, In, Out) :- double(In, Out).
%     run(negate, In, Out) :- negate(In, Out).
%     run(...)  :- ...                  % forever
%
% With `=..` + `call`, ONE rule routes any name whose predicate has the
% right shape — even names you didn't know when you wrote it.
%
% Your task: define `apply_op(Name, In, Out)` that runs the one-in/one-out
% predicate called `Name`, passing `In` and `Out`. Build the goal from the
% name and the two arguments, then call it.
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
