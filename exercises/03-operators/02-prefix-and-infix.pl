% Exercise: prefix and infix
%
% Operators are written in different positions:
%
%   - INFIX  — between two arguments:   `a + b`,  `X - Y`
%   - PREFIX — before one argument:     `- X`  (negation),  `\+ Goal`  (not)
%
% Either way it's still just a compound term, so the position only changes
% how you *write* it. And the count of arguments shows the form:
%
%     functor(a - b, -, 2).   % infix  -> arity 2
%     functor(- a,   -, 1).   % prefix -> arity 1
%
% Notice both lines use `-`! The SAME operator `-` is prefix `-/1`
% (negation) and infix `-/2` (subtraction) — and arity, from the previous
% chapter, is exactly what tells them apart.
%
% Your task: define `notation(Term, Form)` where Form is `prefix` when the
% term's operator takes one argument and `infix` when it takes two. (Use
% `functor/3` and look at the arity.)
%
% Footnote: Prolog the language also has POSTFIX operators (after the
% argument), but they are vanishingly rare, and our engine is a deliberate
% subset that doesn't implement them — so we don't either.
%
% (Heads-up: write `- a`, not `- 3`. A `-` glued to a number, like `-3`,
% is read as a negative *number*, not a compound term.)
%
% Delete the marker when done.

% I AM NOT DONE

% Define notation/2 here (two clauses).



% Do not edit below this line

test :-
    notation(- a, prefix),
    notation(\+ foo, prefix),
    notation(a - b, infix),
    notation(2 + 3, infix).
