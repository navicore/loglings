% Solution: 03-compound-terms

describe(T, Name, First) :- functor(T, Name, _Arity), arg(1, T, First).

% Do not edit below this line

test :-
    describe(age(ann, 9), age, ann),
    describe(point(3, 4), point, 3).
