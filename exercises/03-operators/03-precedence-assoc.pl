% Exercise: precedence and associativity
%
% When operators combine, two rules decide how the term is shaped — i.e.
% which compound term the infix sugar really stands for.
%
% PRECEDENCE — which operator binds tighter:
%
%     2 + 3 * 4   is   2 + (3 * 4)   = 14    (`*` binds tighter than `+`)
%
% ASSOCIATIVITY — which side groups first when an operator repeats. It is
% NOT always left-to-right; it depends on the operator:
%
%     10 - 3 - 2  is   (10 - 3) - 2  = 5     (`-` is LEFT-associative)
%     2 ^ 3 ^ 2   is   2 ^ (3 ^ 2)   = 512   (`^` is RIGHT-associative)
%
% (If `^` grouped left, `(2 ^ 3) ^ 2` would be 64 — but it doesn't.)
%
% Your task: define three rules, each using `is/2`, where you add the
% parentheses yourself to land the stated result:
%   1. `answer(X)`        — add 2 and 3 FIRST, then multiply by 4  -> 20
%   2. `left_grouped(Y)`  — group `10 - 3 - 2` the way `-` does     -> 5
%   3. `right_grouped(Z)` — group `2 ^ 3 ^ 2` the way `^` does      -> 512
%
% Delete the marker when done.

% I AM NOT DONE

% Define answer/1, left_grouped/1, and right_grouped/1 here.



% Do not edit below this line

test :-
    answer(20),
    A is 10 - 3 - 2, left_grouped(Y),  Y =:= A, Y =:= 5,
    B is 2 ^ 3 ^ 2,  right_grouped(Z), Z =:= B, Z =:= 512.
