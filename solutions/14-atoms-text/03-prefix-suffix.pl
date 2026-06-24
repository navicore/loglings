% Solution: 03-prefix-suffix

starts_with(Atom, Prefix) :- atom_concat(Prefix, _, Atom).
ends_with(Atom, Suffix) :- atom_concat(_, Suffix, Atom).

% Do not edit below this line

test :-
    starts_with(foobar, foo),
    starts_with(hello, hello),
    \+ starts_with(foobar, bar),
    ends_with(foobar, bar),
    ends_with(hello, hello),
    \+ ends_with(foobar, foo).
