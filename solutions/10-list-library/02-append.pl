% Solution: 02-append

sentence(Subj, Verb, Obj, S) :-
    append(Subj, Verb, SV),
    append(SV, Obj, S).

% Do not edit below this line

test :-
    sentence([the, cat], [sat], [on, it], S),
    S == [the, cat, sat, on, it],
    sentence([i], [see], [you], S2),
    S2 == [i, see, you].
