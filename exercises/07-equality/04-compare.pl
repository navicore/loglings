% Exercise: compare/3 (the three-way comparison)
%
% `@<` and friends each answer one yes/no question. Often you want the
% whole answer at once — less, equal, or greater — without calling three
% operators. That's `compare/3`:
%
%     compare(Order, X, Y)
%
% It binds Order to one of three atoms, by the same standard order of
% terms you just learned:
%
%     <   when X comes before Y
%     =   when X and Y are the identical term
%     >   when X comes after Y
%
% Examples:
%
%     compare(O, 1, 2).        % O = <
%     compare(O, foo, foo).    % O = =
%     compare(O, b, a).        % O = >
%
% Note: those result atoms are the operators `<` `=` `>` used as plain
% atoms. To compare against one you must parenthesize it — `O == (<)` —
% so the reader doesn't try to parse `<` as an operator.
%
% Your task: define `order_of(X, Y, O)` true when O is the standard-order
% relationship of X to Y. One call to `compare/3` does it.
%
% Delete the marker when done.

% I AM NOT DONE

% Define order_of/3 here.



% Do not edit below this line

test :-
    order_of(1, 2, O1), O1 == (<),
    order_of(5, 5, O2), O2 == (=),
    order_of(b, a, O3), O3 == (>),
    order_of(1, foo(x), O4), O4 == (<),
    order_of(foo(x), a, O5), O5 == (>).
