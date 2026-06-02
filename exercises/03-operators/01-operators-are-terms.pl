% Exercise: operators are terms
%
% Here is the secret that makes Prolog click: `+`, `-`, `*`, `<`, even
% the comma `,` and the `:-` in a rule are all OPERATORS — just a
% convenient way of writing compound terms. The expression
%
%     2 + 3
%
% *is* the compound term `+(2, 3)`. Same term, two spellings. Writing it
% with the operator between the arguments (INFIX) is purely cosmetic.
%
% The `=..` operator (pronounced "univ") makes this visible — it turns a
% term into a list of `[Functor | Arguments]`, and back:
%
%     ?- (2 + 3) =.. L.
%     L = [+, 2, 3].
%
%     ?- T =.. [*, 4, 5].
%     T = 4 * 5.
%
% Your task: define `decompose(Expr, Op, Left, Right)` that pulls a binary
% expression apart into its operator and two operands, using `=..`.
%
% Delete the marker when done.

% I AM NOT DONE

% Define decompose/4 here.



% Do not edit below this line

test :-
    decompose(2 + 3, +, 2, 3),
    decompose(10 * 4, *, 10, 4),
    decompose(a - b, -, a, b).
