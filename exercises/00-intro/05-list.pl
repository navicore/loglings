% Exercise 5: Lists and membership
%
% Lists in Prolog look like   [1, 2, 3]   — square brackets, comma-separated.
% Lists can mix any terms:    [apple, 42, foo(bar)]   is fine.
%
% The standard library gives you  `member/2`:
%
%     member(Element, List)
%
% is true when Element appears somewhere in List. Use it as a check:
%
%     ?- member(2, [1, 2, 3]).
%     true.
%
% Your task: define a fact `pantry/1` whose single argument is a list
% containing exactly the items `flour`, `sugar`, and `eggs`, in any order.
%
% Delete the marker when done.

% I AM NOT DONE

% Define pantry/1 here. Example shape:    pantry([item1, item2, item3]).



% Do not edit below this line

:- dynamic(pantry/1).
test :-
    pantry(Items),
    member(flour, Items),
    member(sugar, Items),
    member(eggs,  Items).
