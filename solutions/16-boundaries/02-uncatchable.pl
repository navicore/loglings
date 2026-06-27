% Solution: 02-uncatchable

countup(Target, Target).

countup(Current, Target) :-
    Current < Target,
    Next is Current + 1,
    countup(Next, Target).

% Do not edit below this line

test :-
    countup(0, 5),
    countup(3, 3),
    \+ countup(5, 2).
