% Exercise: native goals — the reflection moment
%
% So far every goal in the encoded program was ANOTHER clause: prove looked it
% up in `clause/2`. But real programs compute. A rule like
%
%     double(X, Y) :- value(X, V), Y is V * 2.
%
% ends in `Y is V * 2` — a call to the builtin `is/2`. There is no
% `clause(Y is V*2, _)` anywhere. If prove tries to look one up, it finds
% nothing and fails — wrongly, since `is/2` should run and bind Y.
%
% prove must RECOGNIZE builtins and run them natively. The tool is a small
% TABLE — one `builtin/1` fact per shape prove should call directly. Here's
% the whole entry for `is/2`, and it's worth slowing down on:
%
%     builtin(_ is _).
%
% This is a FACT, full stop. Its argument `_ is _` is NOT a call — nothing is
% evaluated. It is the COMPOUND TERM `is(_, _)`, stored as data, exactly the
% way `clause(edge(a, b), true)` in 01-encode stored `edge(a, b)` as data. The
% "a compound term can sit inside a fact" idea from chapters 02 and 03, used
% on purpose.
%
% Why does that help? Because querying the table UNIFIES the goal against the
% stored term. When prove meets `Y is V*2` it asks `builtin(Y is V*2)`, i.e.
% `builtin(is(Y, V*2))`. That unifies with the fact `builtin(is(_, _))`: the
% functor `is` and arity 2 line up, and `_` matches anything — so the query
% succeeds for EVERY `is/2` goal, whatever its operands. You've already made
% this move: `clause(G, true)` in 01-encode succeeded by unifying `G` against a
% clause's head, and `clause(connected(X, Y), edge(X, Y))` in 17-02 unifies
% against a head containing variables. `builtin(G)` is the same mechanism — a
% query unifying against a stored term — only the stored term is a PATTERN with
% wildcard `_`s rather than a clause head.
%
% With a way to ASK "is this goal a builtin?", the escape clause is one line:
%
%     prove(G) :- builtin(G), call(G).
%
% `call` runs the goal natively, as if you'd typed it; prove now has two ways
% to handle a goal — look it up (the clause path) or, if the table says so,
% run it directly (the builtin path).
%
% (No cut is needed: a builtin goal has no clause/2 entry, so the lookup clause
% fails cleanly on backtracking. The table simply takes the first chance.)
%
% Your task:
%   1. Add a `builtin/1` entry for `is/2` — the shape `_ is _`.
%   2. Write the native-escape clause for prove, placed BEFORE the clause
%      lookup. Keep prove's other three clauses from 02-conjunction.
%
% Delete the marker when done.

% I AM NOT DONE

clause(edge(a, b), true).
clause(edge(b, c), true).
clause(value(a, 10), true).
clause(value(b, 4), true).
clause(double(X, Y), (value(X, V), Y is V * 2)).

% Add your builtin/1 entry here:



% Define prove/1 here (true, conjunction, native-escape, clause lookup):



% Do not edit below this line

:- dynamic(clause/2).
:- dynamic(builtin/1).
test :-
    prove(double(a, 20)),
    prove(double(b, 8)),
    \+ prove(double(a, 99)).
