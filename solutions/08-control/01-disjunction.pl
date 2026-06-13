% Solution: 01-disjunction

weekend(Day) :- ( Day = saturday ; Day = sunday ).

% Do not edit below this line

test :-
    weekend(saturday),
    weekend(sunday),
    \+ weekend(monday),
    findall(D, weekend(D), Days),
    Days == [saturday, sunday].
