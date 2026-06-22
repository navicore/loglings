% Solution: 03-split-num

split_num([], [], []).
split_num([H | T], [H | Is], Fs) :-
    integer(H),
    split_num(T, Is, Fs).
split_num([H | T], Is, [H | Fs]) :-
    float(H),
    split_num(T, Is, Fs).

% Do not edit below this line

test :-
    split_num([1, 2.5, 3, 4.0], Is, Fs),
    Is == [1, 3],
    Fs == [2.5, 4.0],
    split_num([], E1, E2),
    E1 == [],
    E2 == [].
