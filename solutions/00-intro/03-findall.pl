% Solution: 03-findall

season(spring).
season(summer).
season(autumn).
season(winter).

% Do not edit below this line

:- dynamic(season/1).
test :-
    findall(S, season(S), Seasons),
    length(Seasons, 4).
