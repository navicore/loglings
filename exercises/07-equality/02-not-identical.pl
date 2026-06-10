% Exercise: \== (term non-identity)
%
% `\==/2` is the negation of `==`: true when its two arguments are NOT
% the identical term. It's the natural guard for "make sure these two
% things are different":
%
%     a \== b.           % true
%     1 \== 1.0.         % true  — different terms (though 1 =:= 1.0)
%     foo(x) \== foo(x). % false — they ARE identical
%
% Mind the two backslash operators — they live in different worlds:
%
%     X =\= Y    % numbers: not equal after EVALUATION
%     X \== Y    % terms:   not the identical term
%
% (And don't confuse `\==` with `\=`. `\=` asks "could these FAIL to
% unify?" — so `X \= 1` is *false*, because an unbound X can unify with
% 1. `X \== 1` is *true*, because X is not already the term 1. You'll
% lean on `\==` far more often as a guard.)
%
% Your task: define `distinct(X, Y)` true when X and Y are not the same
% term. Use `\==`.
%
% Delete the marker when done.

% I AM NOT DONE

% Define distinct/2 here.



% Do not edit below this line

test :-
    distinct(a, b),
    distinct(1, 1.0),
    distinct(foo(1), foo(2)),
    \+ distinct(x, x),
    \+ distinct(foo(a, b), foo(a, b)).
