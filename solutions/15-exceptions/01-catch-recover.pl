% Solution: 01-catch-recover

price(apple, 30).
price(bread, 25).
lookup(Item, P) :- ( price(Item, P) -> true ; throw(no_price(Item)) ).

price_or(Item, Default, P) :-
    catch(lookup(Item, P), no_price(_), P = Default).

% Do not edit below this line

test :-
    price_or(apple, 0, A),
    A == 30,
    price_or(bread, 0, B),
    B == 25,
    price_or(gold, 99, C),
    C == 99,
    price_or(silver, 0, D),
    D == 0.
