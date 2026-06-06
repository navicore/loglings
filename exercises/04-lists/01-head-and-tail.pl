% Exercise: head and tail
%
% You met lists back in the intro: `[10, 20, 30]`. Now that you know the
% term model, here's the real story — a list is just a compound term, and
% the square brackets are sugar. Which means unification (`=`, and clause
% heads) can take lists APART.
%
% The pattern is `[H|T]`. It unifies with any NON-EMPTY list, binding H
% to the head (the first element) and T to the tail (the rest of the
% list — always itself a list):
%
%     [H|T] = [10, 20, 30].   % H = 10, T = [20, 30]
%     [H|T] = [only].         % H = only, T = []
%
% Note the second line: a one-element list has head `only` and tail `[]`
% (the empty list). And `[H|T]` does NOT match `[]` — there's no head to
% bind.
%
% Your task: define two facts —
%
%   - `first(List, H)`: true when H is the first element of List
%   - `rest(List, T)`:  true when T is List without its first element
%
% Each is a single fact whose list argument is a `[H|T]` pattern. Use `_`
% for the part you don't care about.
%
% Delete the marker when done.

% I AM NOT DONE

% Define first/2 and rest/2 here.



% Do not edit below this line

:- dynamic(first/2).
:- dynamic(rest/2).
test :-
    first([10, 20, 30], F), F = 10,
    rest([10, 20, 30], R), R = [20, 30],
    first([only], F1), F1 = only,
    rest([only], R1), R1 = [],
    \+ first([], _).
