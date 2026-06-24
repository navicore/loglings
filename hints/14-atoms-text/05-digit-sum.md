# Hint — 05-digit-sum

Each top predicate spells the number into a list, then hands that list to a
helper that totals the digit values. The helper is the sum-a-list shape from
exercise 01 again — an empty list contributes nothing to the total, and the
recursive clause converts the head to its digit value, recurses on the tail,
and adds.

The only thing that changes between the two versions is that conversion step:

- **Chars.** A character is an ATOM, so you can't do arithmetic on it. Recover
  its value by running `number_chars` backwards on a one-element list holding
  just that single character — it reads the number back out.
- **Codes.** A code is already an integer, so no backward conversion is
  needed: the digit's value is its code minus the code of `'0'` (which is 48).
  Plain arithmetic with `is`.

That contrast — convert vs. subtract — is the whole reason both builtins
exist.
