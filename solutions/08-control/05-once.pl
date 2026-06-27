% Solution: 05-once

color(red).
color(green).
color(blue).

first_color(C) :- once(color(C)).

% Do not edit below this line

test :-
    findall(C, color(C), All),
    All == [red, green, blue],
    findall(C, first_color(C), One),
    One == [red],
    first_color(F),
    F == red.
