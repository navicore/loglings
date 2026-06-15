# Hint — 01-member

Use `member` twice in one body, with both calls sharing the SAME
variable. Let the first call walk list A (generating candidates) and the
second call check that same variable against list B. Because they share
the variable, only elements present in both can satisfy the whole rule.

The order matters: the first `member` generates, the second tests.
