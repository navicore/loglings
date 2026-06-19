% Solution: 04-reverse

palindrome(L) :- reverse(L, L).

% Do not edit below this line

test :-
    palindrome([a, b, a]),
    palindrome([1, 2, 2, 1]),
    palindrome([x]),
    palindrome([]),
    \+ palindrome([a, b]),
    \+ palindrome([1, 2, 3]).
