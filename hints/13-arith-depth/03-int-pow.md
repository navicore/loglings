# Hint — 03-int-pow

One clause, one `is/2`. The only decision is which power operator.

You promised an integer result, and only one of the two power operators
keeps integers as integers — the other always hands back a float, even when
the value is whole. Pick that one. Don't trust how the answer prints;
`integer/1` is the judge here.
