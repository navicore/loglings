% Solution: 04-transparency

reading(7).
reading(12).
reading(20).

first_high(R) :- ( reading(R), R > 10, ! ; R = none ).

% Do not edit below this line

test :-
    findall(R, first_high(R), L),
    L == [12].
