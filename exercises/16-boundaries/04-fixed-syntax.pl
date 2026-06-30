% Exercise: a fixed operator table (errors before anything runs)
%
% Every boundary so far showed up at RUN time, as a thrown error. This one is
% earlier: it's caught when plgc reads your file, before a single goal runs.
%
% plgc has a fixed operator table — the prefix and infix operators from the
% earlier chapters (`+ - * // is < > = :- , ;` and friends) and no more. You
% cannot add to it, and a few things other Prologs allow are simply not in the
% grammar:
%
%   * `:- op(700, xfx, likes).`  — no `op/3`. "Unknown directive", a PARSE error.
%   * `5 factorial`              — no postfix operators at all. "expected `.`".
%   * `greeting --> [hello].`    — no DCG `-->` rules. A parse error on `-->`.
%
% Each of these stops the load with exit code 2 (parse error) — the file never
% gets to run. There's no catching a parse error; you just can't write it.
%
% But here's the thing none of that takes away: an operator is only SUGAR for a
% compound term (chapter 03). `3 + 4` is exactly the term `+(3, 4)`; `likes`
% you wanted as an operator is just `likes(mary, wine)`. The fixed table costs
% you nothing in expressiveness — anything you'd reach for a custom operator to
% write, you write as a plain compound, and you can even build that compound
% from its pieces with `=..` (chapter 11).
%
% Your task: prove the equivalence.
%
%   build_sum(A, B, Term) — Term is the sum expression of A and B, built with
%       `=..` from the functor `+` and the two arguments. It must come out
%       EQUAL (`==`) to the very term you'd write infix as `A + B`.
%
%   eval_sum(A, B, V) — build that sum term, then evaluate it with `is`. The
%       engine evaluates the compound `+(A, B)` and the infix `A + B`
%       identically, because they are the same term.
%
%   build_sum(3, 4, T)   gives T = 3 + 4   (i.e. T == 3 + 4 holds)
%   eval_sum(3, 4, V)    gives V = 7
%
% Delete the marker when done.

% I AM NOT DONE

% Define build_sum/3 and eval_sum/3 here.



% Do not edit below this line

test :-
    build_sum(3, 4, T),
    T == 3 + 4,
    eval_sum(3, 4, V),
    V =:= 7,
    eval_sum(10, 20, W),
    W =:= 30.
