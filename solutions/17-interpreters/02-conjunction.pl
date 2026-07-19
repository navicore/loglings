% Solution: 02-conjunction

clause(edge(a, b), true).
clause(edge(b, c), true).
clause(connected(X, Y), edge(X, Y)).
clause(path(X, Y), edge(X, Y)).
clause(path(X, Y), (edge(X, Z), path(Z, Y))).

prove(true).
prove((A, B)) :- prove(A), prove(B).
prove(G) :- clause(G, Body), prove(Body).

% Do not edit below this line

:- dynamic(clause/2).
test :-
    prove(connected(a, b)),
    prove(path(a, c)),
    \+ prove(path(a, d)).
