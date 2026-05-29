% Solution: 04-my-length

mylen([], 0).
mylen([_|T], N) :-
    mylen(T, N1),
    N is N1 + 1.

% Do not edit below this line

test :-
    mylen([], L0), L0 = 0,
    mylen([apple], L1), L1 = 1,
    mylen([a, b, c, d, e], L5), L5 = 5,
    mylen([1, 2, [nested, list], 4], L4), L4 = 4.
