% Exercise: copy_term/2 — a fresh copy with new variables
%
% `copy_term(Term, Copy)` makes Copy structurally identical to Term but
% with BRAND-NEW variables. Variables shared within Term stay shared in the
% copy; they're just renamed apart from the original:
%
%     ?- copy_term(pair(X, X), C).
%     C = pair(_A, _A).        % still one variable used twice — but a new one
%
% Why does this matter? A term with an unbound variable is a template with
% a hole. Bind the hole and it's filled — for good. If you want to fill the
% SAME template more than once, you need a fresh copy each time, or the
% first fill blocks the second.
%
% Your task: define `filled(Template, Value, Result)` that makes a fresh
% copy of Template and unifies THAT copy with Value. Because you bind the
% copy and not Template itself, Template stays untouched and reusable.
%
% Delete the marker when done.

% I AM NOT DONE

% Define filled/3 here.



% Do not edit below this line

test :-
    copy_term(slot(X, Y), C),
    C = slot(a, b),
    X \== Y,
    % One template, filled twice with different values — only possible
    % because each fill works on its own fresh copy:
    filled(item(W), item(apple), R1),
    R1 == item(apple),
    filled(item(W), item(pear), R2),
    R2 == item(pear),
    var(W).
