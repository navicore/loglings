% Exercise: factorial
%
% n! = n × (n-1) × (n-2) × ... × 1, with 0! = 1 by convention.
%
% Same shape as countdown — two clauses, base case + recursive step —
% except now the predicate has TWO arguments: the input N and the
% computed result F.
%
%     factorial(0, 1).
%     factorial(N, F) :- N > 0, ... , F is N * F1.
%
% The recursive step needs a temporary: compute the factorial of N-1
% into F1, then F is N * F1.
%
% Delete the marker when done.

% I AM NOT DONE

% Define factorial/2 here.



% Do not edit below this line

test :-
    factorial(0, F0), F0 = 1,
    factorial(1, F1), F1 = 1,
    factorial(5, F5), F5 = 120,
    factorial(7, F7), F7 = 5040.
