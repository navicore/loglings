% Exercise: \+ (negation as failure)
%
% `\+ Goal` succeeds when Goal CANNOT be proved, and fails when Goal
% can. It's pronounced "not", but read it precisely as "not provable":
%
%     \+ in_stock(milk).   % true if `in_stock(milk)` has no proof
%
% This is the *closed-world assumption*: Prolog treats "I can't prove
% it" as "it's false". If a fact isn't in the database (and can't be
% derived), `\+` of it succeeds.
%
% Two things to keep in mind:
%   - `\+` never binds variables. It runs Goal only to see whether a
%     proof EXISTS, then throws any bindings away. Use it as a test, not
%     a generator.
%   - Give it ground goals. `\+ in_stock(X)` with X unbound asks "is
%     there NO item in stock at all?" — rarely what you want.
%
% Below are facts for what's on the shelf. Your task: define
% `needs_restock(Item)` true when Item is NOT in stock. Use `\+`.
%
% Delete the marker when done.

% I AM NOT DONE

in_stock(apples).
in_stock(bread).
in_stock(cheese).

% Define needs_restock/1 here.



% Do not edit below this line

test :-
    needs_restock(milk),
    needs_restock(eggs),
    \+ needs_restock(apples),
    \+ needs_restock(cheese).
