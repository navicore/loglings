# Hint — 04-negation

A single goal: `\+` in front of the `in_stock` check on the same item.
"Needs restock" is exactly "cannot be proved in stock".

Don't add facts of your own — the whole point is that the items NOT
listed (milk, eggs) have no proof, so `\+` succeeds for them and fails
for the ones that are listed.
