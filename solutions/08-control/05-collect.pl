% Solution: 05-collect

book(dune, sci_fi).
book(hobbit, fantasy).
book(neuromancer, sci_fi).
book(foundation, sci_fi).

titles_in(Genre, Titles) :- findall(T, book(T, Genre), Titles).

% Do not edit below this line

test :-
    titles_in(sci_fi, S),
    S == [dune, neuromancer, foundation],
    titles_in(fantasy, F),
    F == [hobbit],
    titles_in(romance, R),
    R == [].
