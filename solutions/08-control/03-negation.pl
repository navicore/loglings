% Solution: 03-negation

in_stock(apples).
in_stock(bread).
in_stock(cheese).

needs_restock(Item) :- \+ in_stock(Item).

% Do not edit below this line

test :-
    needs_restock(milk),
    needs_restock(eggs),
    \+ needs_restock(apples),
    \+ needs_restock(cheese).
