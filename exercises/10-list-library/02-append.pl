% Exercise: append/3 (glue two lists into one)
%
% `append/3` relates two lists to their concatenation:
%
%     append(Front, Back, Whole)
%
% With the first two arguments bound, it builds the third — the plain
% "join these" mode you'd expect from any language:
%
%     append([a, b], [c], R).     % R = [a, b, c]
%
% You can chain it to join more than two lists: append the first two, then
% append the third onto that result.
%
% Your task: define `sentence(Subj, Verb, Obj, S)` — join three word-lists
% (subject, verb, object) into one flat list S, in that order. You'll need
% TWO appends: combine the first two, then append the third onto the
% result. (Next exercise reveals append's stranger, more powerful side.)
%
% Delete the marker when done.

% I AM NOT DONE

% Define sentence/4 here.



% Do not edit below this line

test :-
    sentence([the, cat], [sat], [on, it], S),
    S == [the, cat, sat, on, it],
    sentence([i], [see], [you], S2),
    S2 == [i, see, you].
