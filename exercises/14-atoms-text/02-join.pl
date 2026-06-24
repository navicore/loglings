% Exercise: gluing atoms together
%
% `atom_concat/3` is the join: give it two atoms and it hands you the one
% atom you get by sticking the second onto the end of the first.
%
%     atom_concat(foo, bar, X)        % X = foobar
%     atom_concat(over, flow, X)      % X = overflow
%
% It joins exactly two atoms — so to put something BETWEEN them, that
% something is just another atom you join in its own step. Two joins, with
% the separator in the middle:
%
%     atom_concat(hello, ' ', T),     % T = 'hello '
%     atom_concat(T, world, G)        % G = 'hello world'
%
% (The space and the result are quoted because they contain a space — that's
% just how an atom with unusual characters is written. `'hello world'` is one
% atom, not two.)
%
% Your task: define `qualify(Module, Name, Qualified)` — join `Module` and
% `Name` with a colon between them, the way a predicate is named in prose.
% So `qualify(lists, append, Q)` gives `Q = 'lists:append'`.
%
% Use the two-step shape above: join `Module` to the separator `':'`, then
% join that to `Name`.
%
% Delete the marker when done.

% I AM NOT DONE

% Define qualify/3 here.



% Do not edit below this line

test :-
    qualify(lists, append, A),
    A == 'lists:append',
    qualify(a, b, B),
    B == 'a:b',
    qualify(user, main, C),
    C == 'user:main'.
