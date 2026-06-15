% Exercise: member/2 (is it in the list? — and generate what's in it)
%
% In chapter 06 you hand-rolled recursion over lists. The standard library
% gives you the common walks for free. The first is `member/2`:
%
%     member(X, List)
%
% It has TWO faces, and that double life is the whole point:
%
%   * As a TEST, with X bound: `member(green, [red,green,blue])` succeeds
%     because green is in the list.
%   * As a GENERATOR, with X unbound: `member(X, [red,green,blue])` offers
%     X = red, then green, then blue on backtracking — so `findall`
%     collects every element.
%
% You don't choose a mode; it's the same predicate, and which behaviour
% you get falls out of whether X is already bound.
%
% Your task: define `shared(A, B, X)` — true when X appears in BOTH lists
% A and B. The trick is to let `member` GENERATE candidates from one list
% and TEST them against the other, all in one rule body.
%
% Delete the marker when done.

% I AM NOT DONE

% Define shared/3 here.



% Do not edit below this line

test :-
    shared([a, b, c], [x, b, c], b),
    \+ shared([a, b], [c, d], _),
    findall(X, shared([1, 2, 3], [2, 3, 4], X), L),
    L == [2, 3].
