# Hint — 06-digit-sum

`digit_sum` itself is two goals: spell `N` into its codes with `number_codes`,
then hand that list of codes to a helper that totals the digit values.

The helper is the sum-a-list shape from exercise 01. An empty list of codes
has nothing to add, so its total can only be one thing — that's your base
case. The recursive clause turns the head code into its digit value, recurses
on the tail to total the rest, and adds the two.

The only new piece is that first conversion. A code is already an integer —
the code for `'0'` is 48, `'1'` is 49, on up to `'9'` at 57 — so the digit a
code stands for is just the code minus 48. Plain arithmetic with `is`, no
backward call needed. (Contrast last exercise, where a *char* was an atom you
had to compare rather than compute on.)

Remember the ordering rule from exercise 01: the recursive call has to run
*before* the `is` that uses its result.
