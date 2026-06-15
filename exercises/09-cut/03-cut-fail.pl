% Exercise: the cut-fail idiom (commit to failure)
%
% You met negation as failure (`\+`) in chapter 08. Here is how that kind
% of "definitely no" is built from scratch, using cut together with the
% goal `fail` (which always fails):
%
%     !, fail
%
% means "commit to THIS clause, then fail" — and because the cut already
% threw away the other clauses, the whole predicate fails. No fallback
% can rescue it. That's a deliberate "stop here, the answer is no."
%
% For example, to make everything allowed EXCEPT a blocklist, let the
% blocklisted case match first, then cut-fail; everything else falls to a
% permissive catch-all:
%
%     allowed(X) :- blocklist(X), !, fail.
%     allowed(_).
%
% The trick is to let a clause HEAD (or a guard) recognize the case you
% want to reject, then `!, fail` to shut the door on it.
%
% Your task uses the same idiom for a hand-rolled "not equal": define
% `different(X, Y)`, true when X and Y are NOT the same term. The move is
% to write a first clause whose head only matches when the two arguments
% are identical — then cut-fail it — with a permissive catch-all second
% clause. (This is exactly how `\=` works.)
%
% Delete the marker when done.

% I AM NOT DONE

% Define different/2 here.



% Do not edit below this line

test :-
    different(a, b),
    \+ different(a, a),
    different(1, 2),
    \+ different(foo, foo).
