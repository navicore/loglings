# Hint — 03-sum-list

You destructured lists in chapter 04; the new move is feeding the tail back
into the same predicate.

Two clauses. The base case is a plain fact about `[]`. The recursive clause
matches `[H|T]`, recurses on T to get the tail's sum, then `is` adds H.
Order matters in the body: you need the tail's sum *before* you can add H
to it.
