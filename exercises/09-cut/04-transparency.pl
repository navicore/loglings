% Exercise: cut is transparent in ( ; )
%
% This one pins down a subtle rule. When a cut sits inside a disjunction
% `( ... ; ... )`, how far does it reach? In standard Prolog (ISO 7.8.4)
% the cut is TRANSPARENT to `;`, `->`, and `,`: it cuts the WHOLE clause,
% not just its own branch. So it discards the other `;` branch AND the
% predicate's remaining clauses AND retries of goals to its left.
%
% Given:
%
%     m(1).  m(2).  m(3).
%     t(X) :- ( m(X), X > 1, ! ; X = fallback ).
%
% trace it: `m(X)` tries 1 (fails `X > 1`), then 2 (passes, hits `!`).
% That cut is transparent — it throws away m's remaining choice (3) AND
% the entire `; X = fallback` branch. Result: `t(X)` yields exactly
% `X = 2`, and nothing else. The fallback never fires.
%
% (It's tempting to expect `fallback` in the answers too — it's sitting
% right there in the other branch. It never comes, and that's the whole
% lesson: the cut is NOT confined to its own branch. It reaches out and
% commits the entire clause.)
%
% Your task: define `t(X)` exactly as shown above — the disjunction with
% a cut in the first branch and `X = fallback` in the second — so that it
% produces only `X = 2`.
%
% Delete the marker when done.

% I AM NOT DONE

m(1).
m(2).
m(3).

% Define t/1 here.



% Do not edit below this line

test :-
    findall(X, t(X), L),
    L == [2].
