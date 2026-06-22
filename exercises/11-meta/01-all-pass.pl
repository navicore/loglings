% Exercise: call/N and your first higher-order predicate
%
% Until now a goal has always been something you WRITE. But a goal can be
% a value held in a variable, and `call` runs it. Plain `call(G)` proves G
% as if you'd typed it; the useful twist is that `call` can ADD arguments:
%
%     ?- call(positive, 5).      % runs positive(5)
%
% So if `Pred` holds the name of a one-argument predicate, `call(Pred, X)`
% runs `Pred(X)` — without you writing the name yourself.
%
% Here's why that matters. Suppose you want "every element passes a test".
% Without `call` you'd write a whole predicate per test, each one the same
% recursion with a different check baked in:
%
%     all_positive([]).            all_even([]).
%     all_positive([H|T]) :-       all_even([H|T]) :-
%         H > 0, all_positive(T).      0 is H mod 2, all_even(T).
%
% Same shape, copied forever. With `call`, the TEST becomes an argument
% and ONE rule covers them all. That is a higher-order predicate: a
% predicate that takes another predicate.
%
% Your task: define `all_pass(Pred, List)` — true when every element of
% List satisfies `Pred`. (Two clauses, like the recursions above, but with
% `call` standing in for the baked-in check.)
%
% Delete the marker when done.

% I AM NOT DONE

positive(X) :- X > 0.
even(X) :- 0 is X mod 2.

% Define all_pass/2 here.



% Do not edit below this line

test :-
    all_pass(positive, [3, 5, 9]),
    all_pass(even, [2, 4, 6]),
    all_pass(positive, []),
    \+ all_pass(positive, [3, -1, 9]),
    \+ all_pass(even, [2, 5, 6]).
