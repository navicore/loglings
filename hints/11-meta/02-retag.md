# Hint — 02-retag

Two uses of `=..`, back to back. First split `Term` into a list whose head
you ignore and whose tail you keep — that tail is the arguments. Then build
`Result` from a list made of `NewName` followed by those same arguments.

The list tail flows out of the first goal and into the second; you never
touch the individual arguments, so it works for any arity.
