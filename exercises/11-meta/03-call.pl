% Exercise: call/N — running a goal, with arguments added
%
% A goal doesn't have to be something you write — it can be a value, and
% `call/1` runs whatever goal it's handed:
%
%     ?- G = animal(dog), call(G).
%
% `call` has a second trick: extra arguments. `call(P, X, Y)` takes `P` —
% the name of a predicate, or a partial goal — and runs it with `X` and
% `Y` appended to its arguments:
%
%     ?- call(writeln, hello).      % runs writeln(hello)
%
% So when `P` is the name of a two-argument predicate, `call(P, X, Y)`
% proves `P(X, Y)` — without you ever writing `P` followed by parentheses.
% That lets a single rule defer WHICH predicate it runs to its caller.
%
% Below are two unrelated binary relations, `sound/2` and `colour/2`. Your
% task: define `relate(Pred, A, B)` that succeeds when the relation named
% `Pred` holds between `A` and `B`. The one rule must serve BOTH relations,
% so it can't name `sound` or `colour` — it runs whichever `Pred` it's
% given.
%
% Delete the marker when done.

% I AM NOT DONE

sound(dog, woof).
sound(cat, meow).

colour(sky, blue).
colour(grass, green).

% Define relate/3 here.



% Do not edit below this line

test :-
    relate(sound, dog, woof),
    relate(colour, sky, blue),
    relate(colour, grass, green),
    \+ relate(sound, dog, meow).
