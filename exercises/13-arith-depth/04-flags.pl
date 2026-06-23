% Exercise: a set of switches packed into one integer
%
% Bitwise operators treat an integer as a row of on/off bits — a compact
% set. This is where `<<`, `/\`, `\/`, and `xor` earn their keep: storing a
% whole collection of yes/no flags in a single number.
%
% Each flag lives at a bit position. `1 << Pos` builds the integer with just
% that one bit on — its "mask":
%
%     1 << 0 = 1      1 << 1 = 2      1 << 2 = 4
%
% (`>>` shifts the other way: `40 >> 3` divides by 2^3, giving 5.)
%
% Then the operators are set algebra on those masks:
%
%     Set \/ Mask              % add a flag      (OR  — turn the bit on)
%     Set /\ Mask  =:= Mask    % is a flag set?  (AND — keep only that bit,
%                              %                  then check it survived)
%     Set xor Mask             % toggle a flag   (flip the bit)
%
% Below, `flag/2` names three positions and `bit/2` turns a name into its
% mask with `<<`. You build the three operations on a permission set, all
% on plain integers.
%
% Your task — three predicates:
%   add_perm(Set, Name, Set2)    : Set2 is Set with Name's flag turned on.
%   has_perm(Set, Name)          : succeeds when Name's flag is on in Set.
%   toggle_perm(Set, Name, Set2) : Set2 is Set with Name's flag flipped.
%
% Get the mask from `bit(Name, Mask)`, then apply the matching operator.
%
% Delete the marker when done.

% I AM NOT DONE

flag(read,  0).
flag(write, 1).
flag(exec,  2).

bit(Name, Mask) :- flag(Name, Pos), Mask is 1 << Pos.

% Define add_perm/3, has_perm/2, toggle_perm/3 here.



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
