# Hint — 03-sum-list

The first time you destructure a list, it can feel magical: `[H|T]`
simultaneously binds H to the head and T to the tail.

## Solution sketch

    sum_list([], 0).
    sum_list([H|T], S) :-
        sum_list(T, S1),
        S is H + S1.
