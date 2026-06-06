% Exercise: skip ahead
%
% The two pattern forms combine: you can list SEVERAL elements before
% the `|`. The pattern
%
%     [A, B|T]
%
% matches any list with at least TWO elements — A gets the first, B the
% second, T everything after. And anywhere you don't care about a value,
% use `_`:
%
%     [_, S|_] = [a, b, c].   % S = b  (skip the first, ignore the rest)
%     [_, S|_] = [a, b].      % S = b  (the rest is just [])
%     [_, S|_] = [a].         % fails — no second element to bind
%
% Your task: define `second(List, S)` — true when S is the second
% element of List. A single fact.
%
% Delete the marker when done.

% I AM NOT DONE

% Define second/2 here.



% Do not edit below this line

:- dynamic(second/2).
test :-
    second([a, b, c], S1), S1 = b,
    second([1, 2], S2), S2 = 2,
    second([x, y, z, w], S3), S3 = y,
    \+ second([only], _),
    \+ second([], _).
