% Solution: 04-spell

reverse_atom(Atom, Reversed) :-
    atom_chars(Atom, Cs),
    reverse(Cs, Rs),
    atom_chars(Reversed, Rs).

% Do not edit below this line

test :-
    reverse_atom(cat, A),
    A == tac,
    reverse_atom(stop, B),
    B == pots,
    reverse_atom(noon, C),
    C == noon,
    reverse_atom(a, D),
    D == a.
