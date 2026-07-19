% Solution: 01-encode

clause(edge(a, b), true).
clause(edge(b, c), true).
clause(connected(X, Y), edge(X, Y)).

prove(G) :- clause(G, true).

% Do not edit below this line

:- dynamic(clause/2).
test :-
    prove(edge(a, b)),
    prove(edge(b, c)),
    \+ prove(edge(a, c)),
    \+ prove(connected(a, b)).
