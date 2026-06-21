# Hint — 04-copy-term

Two goals. First `copy_term` the Template into a fresh Result; then unify
Result with Value. The order matters: you bind the COPY, never the
Template, which is exactly what leaves the original free to be filled
again next time.

If you unified the Template directly instead, the second fill in the test
would clash with the first — that clash is the whole reason `copy_term`
exists.
