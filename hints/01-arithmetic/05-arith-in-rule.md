# Hint — 05-arith-in-rule

The pattern is exactly the worked `double/2` example, with the body
doing N × N instead of N × 2. The first argument is the input; the
second is where the result lands.

## Solution sketch

    square(N, Sq) :- Sq is N * N.
