# Hint — 03-prefix-suffix

Each predicate is a single clause that names `atom_concat/3` with the whole
atom in the result position and one part left open.

For `starts_with`, the known part is the prefix, so it goes where a prefix
goes in a join; the rest of the atom is something you don't care about, so
that slot is an anonymous variable. `ends_with` is the mirror image — the
known part is the suffix, and the don't-care variable is the front.

No `if`, no comparison, no length arithmetic: a split either exists or it
doesn't, and `atom_concat` succeeding or failing IS your yes/no answer.
