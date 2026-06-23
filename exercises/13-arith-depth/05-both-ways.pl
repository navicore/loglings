% Exercise: arithmetic that runs in both directions
%
% `is/2` is a one-way street: it evaluates the right-hand side and binds the
% left. You must know every input — `Y is X + 1` works only once X is known.
% You can't hand it the answer and ask for an input.
%
% `succ/2` and `plus/3` are different — they're RELATIONS, true-or-false
% about their arguments whichever ones you fill in. Leave a hole and they
% solve for it:
%
%     succ(3, Y)        % Y = 4   (forward)
%     succ(X, 4)        % X = 3   (backward — is/2 cannot do this)
%
%     plus(2, 3, S)     % S = 5
%     plus(2, B, 5)     % B = 3   (solve the middle)
%     plus(A, 3, 5)     % A = 2   (solve the first)
%
% `succ(X, Y)` means Y is the next integer after X (both >= 0). `plus(A, B,
% C)` means A + B = C. Same relation, many questions — the multi-mode idea
% from the list library, now in arithmetic.
%
% Your task: define two predicates that inherit this two-way power.
%   adjacent(X, Y) : Y is the integer right after X.
%   sum3(A, B, C)  : A + B = C.
%
% Each is a one-line relation built on the builtin — but because you built it
% on `succ`/`plus` instead of `is`, it answers in whatever direction the
% caller leaves open. The test runs each one forwards AND backwards; that is
% the whole point, and an `is`-based version simply couldn't pass it.
%
% Delete the marker when done.

% I AM NOT DONE

% Define adjacent/2 and sum3/3 here.



% Do not edit below this line

test :-
    adjacent(3, Y),
    Y == 4,
    adjacent(X, 10),
    X == 9,
    sum3(2, 3, S),
    S == 5,
    sum3(2, B, 5),
    B == 3,
    sum3(A, 3, 5),
    A == 2.
