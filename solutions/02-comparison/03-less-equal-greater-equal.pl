% Solution: 03-less-equal-greater-equal

age(ann, 9).
age(bob, 13).
age(carol, 17).
age(dan, 6).
age(eve, 42).
age(finn, 19).

teen(P) :- age(P, A), A >= 13, A =< 19.

% Do not edit below this line

test :- findall(P, teen(P), Teens), Teens = [bob, carol, finn].
