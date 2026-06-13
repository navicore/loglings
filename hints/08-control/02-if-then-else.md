# Hint — 02-if-then-else

Three cases means two `->` arrows and a bare fall-through, all inside one
parenthesised group:

    ( first test  -> first result
    ; second test -> second result
    ; the default
    )

The order matters only in that the default must be last. The two tests
are `N > 0` and `N < 0`; everything else is `zero`.
