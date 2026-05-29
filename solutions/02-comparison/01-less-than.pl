% Solution: 01-less-than

age(ann, 9).
age(bob, 13).
age(carol, 17).
age(dan, 6).

kid(P) :- age(P, A), A < 13.

% Do not edit below this line

test :- findall(P, kid(P), Kids), Kids = [ann, dan].
