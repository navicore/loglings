% Solution: 04-copy-term

filled(Template, Value, Result) :-
    copy_term(Template, Result),
    Result = Value.

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
