% Exercise: standard order of terms (@<)
%
% `==` tells you whether two terms are the same. But Prolog can also
% RANK any two terms — even ones of totally different shapes — in a
% single fixed ordering called the *standard order of terms*. The
% operators are `@<`, `@>`, `@=<`, `@>=` (the `@` distinguishes them
% from the arithmetic `<` `>` `=<` `>=`).
%
% The order across kinds is:
%
%     Variables  <  Numbers  <  Atoms  <  Compound terms
%
%     1 @< a.            % a number sorts before any atom
%     a @< foo(x).       % an atom sorts before any compound
%     1 @< foo(x).       % number before compound
%
% Within the number kind, terms order by VALUE (and a float sorts just
% before an equal-valued integer):
%
%     1 @< 2.            % true
%     2.0 @< 1.          % FALSE — 2.0 is greater than 1
%     1.0 @< 1.          % true  — equal value, float comes first
%
% Within compounds of the same functor, the arguments are compared:
%
%     foo(1) @< foo(2).  % true
%
% Crucially this is NOT arithmetic — `@<` compares terms by shape and
% kind, never by evaluating them. `2 + 2 @< 5` is FALSE: it compares the
% *compound* `+(2,2)` against the *number* 5, and a compound always
% sorts after a number — even though 2 + 2 is arithmetically less than 5.
%
% Your task: define `precedes(X, Y)` true when X comes before Y in the
% standard order of terms. Use `@<`.
%
% Delete the marker when done.

% I AM NOT DONE

% Define precedes/2 here.



% Do not edit below this line

test :-
    precedes(1, a),
    precedes(a, foo(x)),
    precedes(1, 2),
    precedes(apple, banana),
    precedes(1.0, 1),
    \+ precedes(foo(x), 9),
    \+ precedes(2 + 2, 5).
