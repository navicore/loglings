% Exercise: catch a thrown ball and recover
%
% So far an error has been the end of the story — a goal raises one and the
% whole query stops. This chapter gives you the other half: a way to RAISE a
% signal on purpose, and a way to CATCH it and carry on.
%
% Two builtins, a matched pair:
%
%   throw(Ball)            abandons whatever is running and hurls Ball up the
%                          call stack, looking for someone to catch it.
%   catch(Goal, Catcher, Recovery)
%                          runs Goal. If Goal throws a Ball that UNIFIES with
%                          Catcher, the throw stops there and Recovery runs
%                          instead. If Goal just succeeds, catch succeeds with
%                          it and Recovery is never used.
%
% The Ball is any term you like — that's how you say what went wrong. A
% structured ball carries detail:
%
%     catch(throw(no_room(7)), no_room(N), handle(N))    % N = 7 in handle/1
%
% Catcher is matched by UNIFICATION, so `no_room(N)` catches any `no_room(_)`
% ball and binds N to what was inside it. Recovery then runs with that binding
% in hand.
%
% Here's a tiny price book. `lookup/2` finds an item's price, but for an
% unknown item there's no sensible number to return — so it THROWS instead:
%
%     price(apple, 30).
%     price(bread, 25).
%     lookup(Item, P) :- ( price(Item, P) -> true ; throw(no_price(Item)) ).
%
% Your task: define `price_or(Item, Default, P)` — P is the item's price if
% `lookup` finds one, or Default if `lookup` throws `no_price(_)`. So
% `price_or(apple, 0, P)` gives `P = 30`, and `price_or(gold, 99, P)` gives
% `P = 99`.
%
% Wrap the `lookup` call in a catch. The catcher is the shape of ball lookup
% throws; the recovery's job is to make P the default. (Recovery runs in the
% binding environment the catcher set up, so a binding you make there sticks.)
%
% Delete the marker when done.

% I AM NOT DONE

price(apple, 30).
price(bread, 25).
lookup(Item, P) :- ( price(Item, P) -> true ; throw(no_price(Item)) ).

% Define price_or/3 here.



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
