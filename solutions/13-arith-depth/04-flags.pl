% Solution: 04-flags

flag(read,  0).
flag(write, 1).
flag(exec,  2).

bit(Name, Mask) :- flag(Name, Pos), Mask is 1 << Pos.

add_perm(Set, Name, Set2) :-
    bit(Name, Mask),
    Set2 is Set \/ Mask.

has_perm(Set, Name) :-
    bit(Name, Mask),
    Set /\ Mask =:= Mask.

toggle_perm(Set, Name, Set2) :-
    bit(Name, Mask),
    Set2 is Set xor Mask.

% Do not edit below this line

test :-
    add_perm(0, read, S1),
    S1 == 1,
    add_perm(S1, exec, S2),
    S2 == 5,
    has_perm(S2, read),
    has_perm(S2, exec),
    \+ has_perm(S2, write),
    toggle_perm(S2, read, S3),
    S3 == 4,
    \+ has_perm(S3, read),
    Half is 40 >> 3,
    Half == 5.
