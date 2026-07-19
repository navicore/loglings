% Exercise: N-queens by place-and-check
%
% 04-queens-naive generated a COMPLETE board, then tested it. That's wasteful:
% a board whose first two queens already attack is doomed, yet generate-and-test
% fills in the other two queens anyway before rejecting it. At 4 queens that's
% 256 tries; at 5 it's over three thousand — and it already blows the step
% budget. The full-board-then-test approach explodes.
%
% The fix is to check EARLY. PLACE-AND-CHECK: place one queen, and BEFORE
% placing the next, verify it doesn't attack any queen already down. A queen
% that conflicts is rejected on the spot — the entire subtree of boards that
% would have grown from it is never explored. Same puzzle, same answers, a
% fraction of the work. This is the difference between generate-and-test and
% PROPAGATION (prune as you go).
%
% The loop places queens one at a time, counting down:
%
%     place(0, _, Rows, Rows).                       % none left to place: done
%     place(K, N, Placed, Rows) :-
%         K > 0,
%         between(1, N, R),          % choose a row for this column
%         no_attack(R, Placed, 1),   % CHECK IT NOW, against those already placed
%         K1 is K - 1,
%         place(K1, N, [R | Placed], Rows).
%
% `Placed` holds the rows of queens already down, nearest-first — so the head is
% one column away, the next two columns, and so on. `no_attack(R, Placed, 1)`
% walks it with a growing distance D, exactly like `attack/3` from 04 but
% requiring every queen to be SAFE: `R` must differ from each placed row `P`,
% and from both its diagonals (`P + D` and `P - D`).
%
% Your task: write `place/4` and `no_attack/3`. The wrapper
% `queens(N, Rows) :- place(N, N, [], Rows).` is given. `between/3` (chapter 10)
% enumerates rows.
%
% Delete the marker when done.

% I AM NOT DONE

queens(N, Rows) :- place(N, N, [], Rows).

% Define place/4 and no_attack/3 here.



% Do not edit below this line

test :-
    findall(S, queens(4, S), S4),
    member([2, 4, 1, 3], S4),
    member([3, 1, 4, 2], S4),
    findall(S, queens(6, S), S6),
    length(S6, 4).
