% Exercise: a program is data
%
% A Prolog program is, at bottom, a set of rules. Each rule
%
%     head :- body.
%
% reads "head is true when body is." You've been writing these all along, and
% the engine has been running them. But what if YOU got to decide what
% "running" means — to trace it, count its steps, change its search order,
% collect its proofs? That's what this chapter builds. The first step is to
% pull the program out of the engine and treat it as DATA.
%
% Represent each rule as a `clause/2` fact — one fact per rule:
%
%     edge(a, b).                        becomes     clause(edge(a, b), true).
%     path(X, Y) :- edge(X, Y).          becomes     clause(path(X, Y), edge(X, Y)).
%
% A bare fact is just a rule whose body is `true` (it needs nothing else to
% hold). A real rule carries its body verbatim. Notice the name `clause` is
% ours — the engine has no `clause/2` builtin (chapter 16: no dynamic database)
% — so we're free to define it as a plain predicate and store the program in it.
%
% Once the program is data, proving a goal means matching it against a clause's
% head. For now, handle only FACTS: a goal is proven if it matches a clause
% whose body is `true`.
%
% Your task:
%   1. Encode these three as `clause/2` facts:
%        edge(a, b).
%        edge(b, c).
%        connected(X, Y) :- edge(X, Y).
%   2. Define `prove(G)` that succeeds when G matches a FACT (a clause whose
%      body is `true`).
%
% Delete the marker when done.

% I AM NOT DONE

% Encode the three rules above as clause/2 facts here:



% Define prove/1 here (facts only):



% Do not edit below this line

:- dynamic(clause/2).
test :-
    prove(edge(a, b)),
    prove(edge(b, c)),
    \+ prove(edge(a, c)),
    \+ prove(connected(a, b)).
