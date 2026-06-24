% Exercise: crossing between atoms and lists
%
% `atom_length` measured an atom and `atom_concat` joined whole atoms, but
% neither let you get at the characters themselves. `atom_chars/2` does: it's
% the bridge between the atom world and the list world.
%
% Bind the atom and it SPELLS it out — into a list of one-character atoms:
%
%     atom_chars(cat, Cs)        % Cs = [c, a, t]
%
% Bind the list instead and the very same predicate runs the other way,
% SPELLING those characters back into a single atom:
%
%     atom_chars(A, [d, o, g])   % A = dog
%
% One relation, both directions — which argument you leave open decides which
% way it runs, exactly like `atom_concat`. And once an atom is a list of
% characters, every list tool you already know applies to it.
%
% Your task: define `reverse_atom(Atom, Reversed)` — Reversed is Atom spelled
% backwards. So `reverse_atom(cat, R)` gives `R = tac`.
%
% Three steps, and you've met all of them: spell `Atom` out into characters,
% `reverse/2` that list (chapter 10), then spell the reversed list back into
% an atom. The same builtin does the first and last steps, just run in
% opposite directions.
%
% Delete the marker when done.

% I AM NOT DONE

% Define reverse_atom/2 here.



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
