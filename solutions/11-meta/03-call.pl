% Solution: 03-call

sound(dog, woof).
sound(cat, meow).

colour(sky, blue).
colour(grass, green).

relate(Pred, A, B) :- call(Pred, A, B).

% Do not edit below this line

test :-
    relate(sound, dog, woof),
    relate(colour, sky, blue),
    relate(colour, grass, green),
    \+ relate(sound, dog, meow).
