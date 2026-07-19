% Exercise: interpret bodies (and conjunction)
%
% `prove/1` from the last exercise only saw facts — clauses whose body is
% `true`. So `prove(connected(a, b))` *failed*, even though `connected/2` is a
% rule whose body is `edge(a, b)` (which is true). To prove a rule, `prove`
% must look up the clause and then prove its BODY.
%
% And bodies chain with `,`. The goal `(A, B)` reads "prove A, then prove B."
% So `prove` needs to walk conjunctions too.
%
% Three clauses cover it:
%
%     prove(true).                              % the body of every fact
%     prove((A, B)) :- prove(A), prove(B).      % a conjunction: prove each part
%     prove(G) :- clause(G, Body), prove(Body). % a goal: look up, prove body
%
% The recursive clause does double duty: it handles fact bodies (Body = true →
% the first clause) AND rule bodies (Body = some goal → look THAT up too).
% Recursion takes care of itself — proving a body just calls prove on a goal,
% same as the original query.
%
% The `path/2` rules below are recursive: `path(a, c)` follows `edge(a, b)`
% then `path(b, c)`. With the three clauses above, that "just works" — no
% special handling needed for recursion in the encoded program.
%
% Your task: define `prove/1` with the three clauses above (the encoded program
% is given).
%
% Delete the marker when done.

% I AM NOT DONE

clause(edge(a, b), true).
clause(edge(b, c), true).
clause(connected(X, Y), edge(X, Y)).
clause(path(X, Y), edge(X, Y)).
clause(path(X, Y), (edge(X, Z), path(Z, Y))).

% Define prove/1 here (three clauses):



% Do not edit below this line

:- dynamic(clause/2).
test :-
    prove(connected(a, b)),
    prove(path(a, c)),
    \+ prove(path(a, d)).
