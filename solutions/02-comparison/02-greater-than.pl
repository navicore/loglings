% Solution: 02-greater-than

age(ann, 9).
age(bob, 13).
age(carol, 17).
age(dan, 6).
age(eve, 42).

adult(P) :- age(P, A), A > 17.

% Do not edit below this line

test :- findall(P, adult(P), Adults), Adults = [eve].
