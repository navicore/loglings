% Solution: 02-join

qualify(Module, Name, Qualified) :-
    atom_concat(Module, ':', T),
    atom_concat(T, Name, Qualified).

% Do not edit below this line

test :-
    qualify(lists, append, A),
    A == 'lists:append',
    qualify(a, b, B),
    B == 'a:b',
    qualify(user, main, C),
    C == 'user:main'.
