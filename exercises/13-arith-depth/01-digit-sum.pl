% Exercise: pulling a number apart, digit by digit
%
% Integer division and remainder are the two halves of one idea: split a
% number by a divisor into a whole quotient and what's left over.
%
%     N // D    % how many whole times D fits into N  (integer quotient)
%     N mod D   % what's left over                     (remainder)
%
% With D = 10 they become a digit machine. `N mod 10` is the last digit;
% `N // 10` is everything BUT the last digit:
%
%     1234 mod 10  = 4        1234 // 10 = 123
%
% Peel the last digit, shrink the number, repeat — that's how you walk the
% digits of a number without ever turning it into text.
%
% Your task: define `digit_sum(N, S)` — S is the sum of N's decimal digits,
% for N >= 0. So `digit_sum(1234, S)` gives `S = 10` (1+2+3+4), and any
% single digit is its own sum.
%
% Recurse: a number below 10 is a single digit — the base case, where the
% number IS the sum. Otherwise split off `N mod 10`, recurse on `N // 10`,
% and add the peeled digit to whatever the rest sums to.
%
% Delete the marker when done.

% I AM NOT DONE

% Define digit_sum/2 here.



% Do not edit below this line

test :-
    digit_sum(0, A),
    A == 0,
    digit_sum(7, B),
    B == 7,
    digit_sum(1234, C),
    C == 10,
    digit_sum(99, D),
    D == 18.
