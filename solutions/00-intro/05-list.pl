% Solution: 05-list

pantry([flour, sugar, eggs]).

% Do not edit below this line

:- dynamic(pantry/1).
test :-
    pantry(Items),
    member(flour, Items),
    member(sugar, Items),
    member(eggs,  Items).
