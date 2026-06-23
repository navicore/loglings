% Exercise: same number, different type — choosing a power operator
%
% Prolog has two power operators, and the difference is not the value, it's
% the TYPE of the answer (remember integer vs float from the last chapter):
%
%     2 ^ 10    % integer power  -> 1024   (an integer)
%     2 ** 10   % float power    -> 1024.0 (a float)
%
% Here's the trap: plgc PRINTS a whole-valued float without its `.0`, so
% `X is 2 ** 10` shows `X = 1024` on screen — identical to the `^` answer.
% They are NOT the same term. The printer hides it; `integer/1` and
% `float/1` don't:
%
%     ?- X is 2 ** 10, float(X).    % true  — it really is 1024.0
%     ?- X is 2 ^ 10, integer(X).   % true  — this one is 1024
%     ?- 1024.0 == 1024.            % false — different terms!
%
% Division splits the same way: `/` always gives a float (`7 / 2` is 3.5,
% and even `4 / 2` is 2.0), while `//` always gives an integer.
%
% Your task: define `int_pow(Base, Exp, P)` where P must be a genuine
% INTEGER — Base raised to Exp, usable where an integer is required (like the
% bit positions in the next exercise). `int_pow(2, 10, P)` gives `P = 1024`
% as an integer; `int_pow(5, 3, P)` gives 125.
%
% It is a one-liner — the lesson is the CHOICE. Reach for `**` and it will
% even print the right digits, but the hidden float breaks the integer
% promise (the test checks `integer(P)`). Pick the operator whose type
% matches what you said you'd return.
%
% Delete the marker when done.

% I AM NOT DONE

% Define int_pow/3 here.



% Do not edit below this line

test :-
    int_pow(2, 10, P),
    P == 1024,
    integer(P),
    int_pow(5, 3, Q),
    Q == 125,
    F is 2 ** 10,
    float(F),
    F =:= 1024,
    G is 7 / 2,
    float(G),
    G =:= 3.5,
    H is 7 // 2,
    integer(H),
    H == 3.
