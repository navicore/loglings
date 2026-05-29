# Hint — 04-rule

A rule has the shape:

    head(Args) :- body1, body2, ..., bodyN.

Read `:-` as "if" and the comma as "and." The body is a list of goals that
must all succeed for the head to succeed.

For grandparent, you want: "X is a grandparent of Z if there exists some Y
such that X is parent of Y, and Y is parent of Z." The variable Y appears
twice — Prolog will find a value for Y that makes both halves true.

## Solution sketch

    grandparent(X, Z) :- parent(X, Y), parent(Y, Z).
