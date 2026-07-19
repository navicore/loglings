% Exercise: N-queens by generate-and-test
%
% 01–03 searched a state space for a PATH. N-queens is a different kind of
% search: not "find a route" but "find a CONFIGURATION that satisfies a
% constraint." The method is GENERATE-AND-TEST — generate a candidate, then
% check it. Prolog's backtracking does the "try the next one" for free.
%
% The puzzle: place 4 queens on a 4×4 board so no two attack each other (same
% row, column, or diagonal). One queen per column is forced, so a candidate is
% just a choice of ROW per column: a list `[R1, R2, R3, R4]` where `Ri` is the
% row of the queen in column `i`. The list INDEX is the column; the VALUE is
% the row.
%
% The generate-and-test shape:
%
%     queens(Rows) :- length(Rows, 4),          % a 4-element skeleton
%                     all_member(Rows, [1,2,3,4]), % every row in 1..4 (generate)
%                     safe(Rows).               % no attacks (test)
%
% `all_member` and `safe` are given. Your task is the two missing pieces:
%   - `queens/1`, the generate-and-test rule above; and
%   - `attack/3`, the heart of the constraint. `attack(Q, D, Rows)` is true if
%     a queen at row Q attacks some queen in Rows, where the head of Rows is
%     **D columns** away (D=1 for the next column, D=2 for the one after…).
%     A queen attacks when the other queen is on the SAME ROW (`Q =:= Q2`), or
%     on a DIAGONAL — and a diagonal means the row difference equals the column
%     distance: `Q =:= Q2 + D` or `Q =:= Q2 - D`. Recurse down Rows with `D+1`.
%
% (This generate-ALL-then-test approach tries all 256 placements. It works at
% 4 queens — but watch what happens at 5. 05-queens-pruned is the fix.)
%
% Delete the marker when done.

% I AM NOT DONE

all_member([], _).
all_member([H|T], D) :- member(H, D), all_member(T, D).

safe([]).
safe([Q|Qs]) :- \+ attack(Q, 1, Qs), safe(Qs).

% Define queens/1 and attack/3 here.



% Do not edit below this line

test :-
    findall(S, queens(S), Solutions),
    Solutions = [_, _],
    member([2, 4, 1, 3], Solutions),
    member([3, 1, 4, 2], Solutions).
