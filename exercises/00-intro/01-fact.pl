% Exercise 1: Your first fact
%
% A "fact" in Prolog is a statement that something is true. Facts end with a
% period. Lowercase names are atoms (constant values); the parentheses give
% the fact arguments.
%
%     cat(whiskers).
%
% reads as "whiskers is a cat."
%
% Your task: add a fact that says `apple` is a `fruit`.
% When you think you're done, delete the `% I AM NOT DONE` line below.

% I AM NOT DONE

cat(whiskers).



% Do not edit below this line

:- dynamic(fruit/1).
test :- fruit(apple).
