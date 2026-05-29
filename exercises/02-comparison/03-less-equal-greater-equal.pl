% Exercise: =< and >=
%
% The "or-equal" comparisons. Both include the equal case:
%
%     5 =< 5.   % succeeds (less than OR equal)
%     5 >= 5.   % succeeds (greater than OR equal)
%     4 =< 5.   % succeeds
%     6 >= 5.   % succeeds
%
% Watch out: it's spelled `=<` — NOT `<=`. Many languages use `<=`;
% Prolog reserves `<=` for arrow-shaped notation in other operators.
% Get used to typing `=<`.
%
% Your task: define `teen(Person)` true when Person's age is between
% 13 and 19, INCLUSIVE on both ends. You'll need both `=<` and `>=`
% in the same rule body (comma between them = "and").
%
% Delete the marker when done.

% I AM NOT DONE

age(ann, 9).
age(bob, 13).
age(carol, 17).
age(dan, 6).
age(eve, 42).
age(finn, 19).

% Define teen/1 here.



% Do not edit below this line

test :- findall(P, teen(P), Teens), Teens = [bob, carol, finn].
