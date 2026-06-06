% Exercise: greater-than (>)
%
% The mirror image of `<`. Succeeds when the left number is strictly
% greater than the right:
%
%     7 > 3.       % succeeds
%     5 > 5.       % fails (strict)
%     10 > 2 + 3.  % succeeds (right side evaluates to 5)
%
% Same `age/2` facts as the previous exercise. Your task: define
% `adult(Person)` true when Person's age is strictly greater than 17.
%
% Delete the marker when done.

% I AM NOT DONE

age(ann, 9).
age(bob, 13).
age(carol, 17).
age(dan, 6).
age(eve, 42).

% Define adult/1 here.



% Do not edit below this line

test :- findall(P, adult(P), Adults), Adults = [eve].
