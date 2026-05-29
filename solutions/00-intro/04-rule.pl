% Solution: 04-rule

parent(tom, bob).
parent(bob, ann).
parent(bob, pat).

grandparent(X, Z) :- parent(X, Y), parent(Y, Z).

% Do not edit below this line

test :- grandparent(tom, ann), grandparent(tom, pat).
