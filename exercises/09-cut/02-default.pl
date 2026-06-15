% Exercise: commit to the matching clause, fall through to a default
%
% The most common real use of cut: a table of clauses tried top to
% bottom, where the first one that applies should WIN and the others —
% including a catch-all default at the bottom — must not also fire.
%
% Two flavours of cut live here, and the difference is worth seeing:
%
%   * A GREEN cut prunes work WITHOUT changing the answers. If every
%     clause is already guarded so only one can ever match, the cut just
%     spares the engine from trying the rest. Remove it and you get the
%     same answers, only slower. For instance:
%
%         abs(X, X) :- X >= 0, !.
%         abs(X, Y) :- X < 0, Y is -X.
%
%     Drop that `!` and `abs(5, A)` still gives only `A = 5` — clause two
%     fails its own guard. The cut is pure efficiency.
%
%   * A LOAD-BEARING cut changes the answers — usually because the
%     fallthrough clause is an UNGUARDED default. There the cut is the
%     only thing stopping the default from firing too. That's the kind
%     you'll write here.
%
% Above the fold is a `role/2` table. You want `access(User, Level)` to
% report a user's level — and anyone NOT in the table gets `none`. The
% trap: without a cut, `access(admin, L)` gives `full` and THEN, on
% backtracking, also `none` — claiming the admin has no access. The cut
% commits to the real match so the default can't undercut it.
%
% Your task: define `access(User, Level)` — look the user up in `role/2`
% and commit with a cut; add a final catch-all clause giving `none`.
%
% Delete the marker when done.

% I AM NOT DONE

role(admin, full).
role(editor, write).
role(viewer, read).

% Define access/2 here.



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
