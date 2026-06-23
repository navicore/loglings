% Exercise: wrapping around a clock — and why mod, not rem
%
% Four operators split a division, and they come in two PAIRS that differ
% only on negative numbers — exactly where bugs hide.
%
%     N // D , N rem D    % // truncates toward zero;  rem matches it
%     N div D , N mod D   % div floors (toward -inf);  mod matches it
%
% For non-negative numbers all four agree. On negatives they split:
%
%     -5 // 2  = -2        -5 rem 2 = -1      (toward zero)
%     -5 div 2 = -3        -5 mod 2 =  1      (floored)
%
% The remainder takes its sign from its partner's rule: `rem` follows the
% DIVIDEND (so `-5 rem 2` is negative), while `mod` follows the DIVISOR (so
% `-5 mod 2` is positive, because 2 is positive).
%
% That sign rule is the whole reason a clock uses `mod`. To find the hour
% after moving some delta — which may be negative, winding backwards — you
% want a result in 0..11 no matter what. `mod 12` guarantees it, because 12
% is positive; `rem 12` would hand you a negative "hour" for backward moves.
%
% Your task: define `clock(Start, Delta, Hour)` — on a 12-hour face numbered
% 0..11, Hour is where you land starting at Start and moving Delta hours
% (Delta may be negative). `clock(10, 5, H)` gives 3; `clock(3, -5, H)`
% gives 10.
%
% Add Start and Delta, then bring the total onto the face with the operator
% that keeps the result in range.
%
% Delete the marker when done.

% I AM NOT DONE

% Define clock/3 here.



% Do not edit below this line

test :-
    clock(10, 5, H1),
    H1 == 3,
    clock(3, -5, H2),
    H2 == 10,
    clock(0, -1, H3),
    H3 == 11,
    M is -5 mod 12,
    M == 7,
    R is -5 rem 12,
    R == -5,
    D is -5 div 12,
    D == -1.
