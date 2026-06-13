% Exercise: once/1 (commit to the first solution)
%
% Some goals have many solutions. Sometimes you want just the FIRST and
% no backtracking into the rest. `once/1` does exactly that:
%
%     once(Goal)
%
% proves Goal, keeps the first solution, and commits — Goal will not be
% retried on backtracking. It's `( Goal -> true ; fail )` in a tidier
% package.
%
% With three colour facts, `color(C)` normally offers red, green, blue
% in turn. Wrapped in `once`, it offers only red:
%
%     findall(C, color(C), L).        % L = [red, green, blue]
%     findall(C, once(color(C)), L).  % L = [red]
%
% (`once` doesn't pick a "best" — just the first solution Prolog finds,
% which is clause order.)
%
% Your task: define `first_color(C)` true for only the FIRST colour,
% using `once`.
%
% Delete the marker when done.

% I AM NOT DONE

color(red).
color(green).
color(blue).

% Define first_color/1 here.



% Do not edit below this line

test :-
    findall(C, color(C), All),
    All == [red, green, blue],
    findall(C, first_color(C), One),
    One == [red],
    first_color(F),
    F == red.
