% Exercise: =\= (arithmetic inequality)
%
% The companion of `=:=`. Both sides are evaluated; succeeds when they
% are NOT equal as numbers:
%
%     5 =\= 6.         % succeeds
%     5 =\= 5.         % fails
%     2 + 3 =\= 4 + 2. % succeeds (5 vs 6)
%
% Spelled `=\=` (equals, backslash, equals). The backslash here is the
% "negation" of `=:=` — you'll see this pattern again in other Prolog
% operators.
%
% Below you'll find facts for student scores. Your task: define
% `not_perfect(Student)` true when the student's score is NOT 100.
% Use `=\=` for the comparison.
%
% Delete the marker when done.

% I AM NOT DONE

score(ann, 87).
score(bob, 100).
score(carol, 92).
score(dan, 100).
score(eve, 73).

% Define not_perfect/1 here.



% Do not edit below this line

test :-
    findall(S, not_perfect(S), Imperfect),
    Imperfect = [ann, carol, eve].
