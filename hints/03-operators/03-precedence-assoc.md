# Hint — 03-precedence-assoc

Each rule is just `Name(R) :- R is <expression>.` — the work is choosing where
the parentheses go.

- `answer`: `*` binds tighter than `+`, so to add first you must parenthesize
  the addition.
- `left_grouped`: `-` groups left, so the leftmost subtraction happens first.
- `right_grouped`: `^` groups right, so the rightmost power happens first.

If a grouping is wrong the result won't match, and the test will tell you.
