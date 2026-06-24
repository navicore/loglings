% Exercise: atom_concat run BACKWARDS
%
% Just like `append/3` on lists, `atom_concat/3` is not a one-way join — it's
% a RELATION between three atoms, and binding different arguments runs it
% different ways. Last exercise you bound the two parts and asked for the
% whole. Bind the WHOLE and leave a part open, and the same builtin becomes a
% SPLITTER.
%
% Leave the first part open and it solves for the prefix that's left when you
% peel a known suffix off the end; leave the second part open and it solves
% for what remains after a known prefix:
%
%     atom_concat(foo, Rest, foobar)     % Rest = bar   (known prefix peeled)
%     atom_concat(Front, bar, foobar)    % Front = foo  (known suffix peeled)
%
% And here's the move that matters: if a part simply DOESN'T fit, there's no
% solution and the goal fails — so the same call doubles as a test. Asking
% "does `foobar` begin with `foo`?" is just asking whether
% `atom_concat(foo, _, foobar)` has any solution at all (you don't care what
% the rest is — that's what `_` is for).
%
% Your task: define two predicates, each a single relational clause.
%   starts_with(Atom, Prefix) : true when Atom begins with Prefix.
%   ends_with(Atom, Suffix)   : true when Atom ends with Suffix.
%
% Think relationally: Atom IS Prefix followed by something (for `starts_with`),
% or something followed by Suffix (for `ends_with`). The "something" is the
% part you leave open.
%
% Delete the marker when done.

% I AM NOT DONE

% Define starts_with/2 and ends_with/2 here.



% Do not edit below this line

test :-
    starts_with(foobar, foo),
    starts_with(hello, hello),
    \+ starts_with(foobar, bar),
    ends_with(foobar, bar),
    ends_with(hello, hello),
    \+ ends_with(foobar, foo).
