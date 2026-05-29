% Exercise 4: Rules
%
% A "rule" gives a name to a more complex pattern. The head (left of `:-`)
% is what's being defined; the body (right) is the conditions that must be
% true. Variables start with an uppercase letter.
%
%     animal(X) :- cat(X).
%     animal(X) :- dog(X).
%
% reads as "X is an animal if X is a cat, or if X is a dog."
%
% Below you'll find facts for parents. Your task: write a rule called
% `grandparent` that takes two arguments — a person and one of their
% grandchildren — and is true when there's a parent chain between them.
%
% Hint: think "X is the parent of some Y, AND Y is the parent of Z".
% In Prolog, AND inside a rule body is written as a comma.
%
% Delete the marker when done.

% I AM NOT DONE

parent(tom, bob).
parent(bob, ann).
parent(bob, pat).

% Define grandparent/2 here:




% Do not edit below this line

test :- grandparent(tom, ann), grandparent(tom, pat).
