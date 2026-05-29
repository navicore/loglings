% Exercise: less-than (<)
%
% The `<` operator compares two evaluated numbers and succeeds if the
% left is strictly less than the right. Like `is/2`, it evaluates BOTH
% sides — you don't need a separate `is` step:
%
%     3 < 7.       % succeeds
%     5 < 5.       % fails
%     2 + 1 < 5.   % succeeds (left side evaluates to 3)
%
% Used inside a rule body, it acts as a *guard*: the rest of the body
% runs only when the comparison holds.
%
% Below you'll find a few `age/2` facts. Your task: define a rule
% `kid(Person)` that's true when Person's age is strictly less than 13.
%
% Delete the marker when done.

% I AM NOT DONE

age(ann, 9).
age(bob, 13).
age(carol, 17).
age(dan, 6).

% Define kid/1 here.



% Do not edit below this line

test :- findall(P, kid(P), Kids), Kids = [ann, dan].
