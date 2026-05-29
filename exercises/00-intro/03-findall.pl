% Exercise 3: Collecting solutions with findall/3
%
% A query with a variable can have many answers. Sometimes you want them all
% as a list. That's what `findall/3` is for:
%
%     findall(Template, Goal, List)
%
% means "collect every binding of Template that makes Goal true, into List."
%
% For example, given:
%     color(sky, blue).
%     color(grass, green).
%     color(rose, red).
%
% the query  `findall(C, color(_, C), Colors)`  binds  `Colors = [blue, green, red]`.
%
% Your task: define facts for the four seasons (`spring`, `summer`, `autumn`,
% `winter`) so that `findall/3` collects exactly four of them.
%
% Delete the marker when done.

% I AM NOT DONE

% Add your season facts using the predicate name `season/1`:




% Do not edit below this line

:- dynamic(season/1).
test :-
    findall(S, season(S), Seasons),
    length(Seasons, 4).
