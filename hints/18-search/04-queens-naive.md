# Hint — 04-queens-naive

`queens/1` is the three-part pattern from the comment: build the skeleton,
generate every row assignment, then test it.

`attack/3` is the real work. A queen at row `Q` attacks the head `Q2` of the
remaining rows (which sits `D` columns to the right) in three ways:

- same row: `Q =:= Q2`;
- diagonal going up: `Q =:= Q2 + D`;
- diagonal going down: `Q =:= Q2 - D`.

Those are three separate `attack` clauses — each is a one-line way to succeed.
Then a fourth clause recurses: skip the head, and check the rest with the
column distance increased (`D1 is D + 1`), because the next column is one step
further away.
