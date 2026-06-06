% Exercise: exact shapes
%
% `[H|T]` matches any list with AT LEAST one element. Leave out the `|`
% and you get something different — an EXACT shape:
%
%     [X]       % matches only one-element lists
%     [X, Y]    % matches only two-element lists
%     [X, Y, Z] % matches only three-element lists
%
% Compare:
%
%     [X, Y] = [a, b].       % X = a, Y = b
%     [X, Y] = [a].          % fails — too short
%     [X, Y] = [a, b, c].    % fails — too long
%     [X|T]  = [a, b, c].    % X = a, T = [b, c] — the | absorbs the rest
%
% The `|` is the difference between "exactly this many" and "this many,
% then whatever".
%
% Your task: define `duo(List, X, Y)` — true when List has EXACTLY two
% elements, X and Y, in order. A single fact.
%
% Delete the marker when done.

% I AM NOT DONE

% Define duo/3 here.



% Do not edit below this line

:- dynamic(duo/3).
test :-
    duo([a, b], A, B), A = a, B = b,
    duo([1, 2], One, Two), One = 1, Two = 2,
    \+ duo([a], _, _),
    \+ duo([a, b, c], _, _).
