# Hint — 05-double-each

The exercise spells out the answer — the focus is *understanding* the
pattern rather than guessing it.

Re-read the second clause aloud: "doubling a non-empty list with head H
and tail T yields a list whose head is H times 2 and whose tail is the
doubled T." Prolog isn't returning anything; it's matching shapes. By
the time `double_each(T, T2)` finishes, T2 is the doubled tail, and the
cons cell `[H2|T2]` is the complete doubled result.
