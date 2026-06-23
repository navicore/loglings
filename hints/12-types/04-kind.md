# Hint — 04-kind

One clause whose body is a single if-then-else chain:

    kind(T, K) :-
        ( number(T)   -> K = ...
        ; atom(T)     -> K = ...
        ; is_list(T)  -> K = ...
        ; compound(T) -> K = ...
        ).

Fill in each `K = ` with the matching kind. The order is the whole point:
the chain tries the tests top to bottom and commits to the first that
succeeds, so put the more specific / overlapping cases earlier. `atom`
before `is_list` makes `[]` an atom; `is_list` before `compound` keeps
real lists from being reported as plain compounds.
