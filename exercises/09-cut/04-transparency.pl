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
% Now put it to work on different data. Above the fold are three
% `reading/1` facts. Define `first_high(R)` that finds the FIRST reading
% greater than 10 and commits to it — and if no reading qualifies, falls
% back to `R = none`. Build it as a single clause with one disjunction:
% generate-and-test-and-cut in the first branch, the `none` fallback in
% the second. Because the cut is transparent, the moment a reading passes
% it commits and the fallback is dropped — so `findall` returns exactly
% one answer.
%
% Delete the marker when done.

% I AM NOT DONE

reading(7).
reading(12).
reading(20).

% Define first_high/1 here.



% Do not edit below this line

test :-
    findall(R, first_high(R), L),
    L == [12].
