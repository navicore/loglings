% Solution: 04-arity

note(c).
note(d).
note(e).

note(c, 261).
note(a, 440).

arity_of(T, N) :- functor(T, _Name, N).
freq(Name, Hz) :- note(Name, Hz).

% Do not edit below this line

test :-
    arity_of(note(c), 1),
    arity_of(note(c, 261), 2),
    freq(c, 261),
    freq(a, 440).
