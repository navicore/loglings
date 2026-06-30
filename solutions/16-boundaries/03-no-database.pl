% Solution: 03-no-database

no_db(Result) :-
    catch(
        ( assertz(seen(1)), Result = stored ),
        error(existence_error(procedure, _), _),
        Result = no_database
    ).

running_total([], Acc, Acc).
running_total([H | T], Acc, Total) :-
    Acc1 is Acc + H,
    running_total(T, Acc1, Total).

% Do not edit below this line

test :-
    no_db(R),
    R == no_database,
    running_total([3, 4, 5], 0, T),
    T =:= 12,
    running_total([], 0, Z),
    Z =:= 0,
    running_total([10, 20, 30, 40], 0, B),
    B =:= 100.
