% Solution: 03-native

clause(edge(a, b), true).
clause(edge(b, c), true).
clause(value(a, 10), true).
clause(value(b, 4), true).
clause(double(X, Y), (value(X, V), Y is V * 2)).

builtin(_ is _).

prove(true).
prove((A, B)) :- prove(A), prove(B).
prove(G) :- builtin(G), call(G).
prove(G) :- clause(G, Body), prove(Body).

% Do not edit below this line

:- dynamic(clause/2).
:- dynamic(builtin/1).
test :-
    prove(double(a, 20)),
    prove(double(b, 8)),
    \+ prove(double(a, 99)).
