# Hint — 04-flags

Every clause starts the same way: `bit(Name, Mask)` to fetch the flag's
mask. Then one operator each:

- `add_perm`: OR the mask into the set — `Set2 is Set \/ Mask`.
- `toggle_perm`: XOR the mask — `Set2 is Set xor Mask` (flips it on if off,
  off if on).
- `has_perm`: AND the set with the mask to keep only that bit, then check it
  survived — `Set /\ Mask =:= Mask`. No new variable to bind; it either
  holds or it doesn't, so this clause has no third argument.
