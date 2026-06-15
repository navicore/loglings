% Solution: 02-default

role(admin, full).
role(editor, write).
role(viewer, read).

access(User, Level) :- role(User, Level), !.
access(_, none).

% Do not edit below this line

test :-
    access(admin, A1),
    A1 == full,
    access(editor, A2),
    A2 == write,
    access(ghost, A3),
    A3 == none,
    findall(A, access(admin, A), L),
    L == [full].
