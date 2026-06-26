# Hint — 05-count-digit

`count_digit` is two goals: spell `N` into its character list with
`number_chars`, then hand that list to a helper that does the counting.

The helper is the walk-a-list shape from exercise 01. An empty list holds no
matches at all, so its count can only be one thing — that's your base case.
The recursive clause counts the tail first, then decides whether the head adds
to that total.

The head is a one-character atom, and so is `D`, so compare them directly —
`==` for "same character", `\==` for "different". When they match, the head
contributes one more than the tail's total; when they don't, the count is just
the tail's total unchanged. An if-then-else (`-> ;`) inside the body is the
tidy way to pick between those two — and it keeps the count goal *after* the
recursive call, the way exercise 01's ordering rule wants it.

No arithmetic touches the characters themselves here — you only ever compare
them. That's the whole reason this task wants the char (atom) face.
