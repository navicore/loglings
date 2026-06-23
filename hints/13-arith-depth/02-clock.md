# Hint — 02-clock

Two steps in one clause: first add `Start` and `Delta` into a raw total,
then fold that total onto the 0..11 face.

The folding operator is the one whose remainder follows the DIVISOR's sign.
Since the face size 12 is positive, that operator always returns something
in 0..11 — even when the raw total went negative. `rem` would not; it would
leave a backward move sitting at a negative hour.
