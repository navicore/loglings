# Hint — 06-between

Reach for `findall/3` from chapter 00. Its middle argument — the goal —
can be a conjunction: first generate a number with `between`, then test
that number for evenness with the `mod` trick from chapter 01. Wrap those
two goals in parentheses so `findall` treats them as one template.

`findall` keeps every number that passes BOTH, which is exactly the even
ones in range.
