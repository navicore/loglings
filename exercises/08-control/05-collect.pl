% Exercise: findall/3 (collect every solution)
%
% You met `findall/3` back in the intro, and you've just watched it
% quietly collect solutions inside the tests for `once` — now you write
% one yourself. It rounds out a little family you've been building this
% chapter, the "how many solutions do you want?" trio:
%
%     \+ Goal              — succeed if there are NONE
%     once(Goal)           — keep just the FIRST
%     findall(T, Goal, L)  — collect them ALL into the list L
%
% `findall(Template, Goal, List)` re-proves Goal every way it can, and
% for each proof adds a copy of Template to List. Two things set it
% apart from the other two:
%
%   - it NEVER fails. If Goal has no solutions, List is just `[]`
%     (where `\+` would succeed and a bare goal would fail).
%   - Template is a PROJECTION: you pick what to keep from each
%     solution. To collect only the drink from each `likes/2` fact:
%
%         likes(sam, tea).
%         likes(sam, coffee).
%         likes(jo,  water).
%
%         ?- findall(D, likes(sam, D), L).
%         L = [tea, coffee].
%
% Below are some books, each tagged with a genre. Your task: define
% `titles_in(Genre, Titles)` so that Titles is the list of every book
% title in that genre (and `[]` when the genre has none). Wrap a
% `findall` in a rule, with Genre handed in from the outside.
%
% Delete the marker when done.

% I AM NOT DONE

book(dune, sci_fi).
book(hobbit, fantasy).
book(neuromancer, sci_fi).
book(foundation, sci_fi).

% Define titles_in/2 here.



% Do not edit below this line

test :-
    titles_in(sci_fi, S),
    S == [dune, neuromancer, foundation],
    titles_in(fantasy, F),
    F == [hobbit],
    titles_in(romance, R),
    R == [].
