# Hint — 02-join

One clause, two joins. `atom_concat/3` only takes two atoms at a time, so you
can't drop the separator in with a single call — you need an intermediate
atom.

First join the module to the separator `':'`, which gives you a partial
result (`module:`). Then join that partial result to the name. The atom the
first goal produces is what the second goal joins onto — chain them through a
shared variable.

The separator is written `':'` only because a bare colon would read as an
operator; quoted, it's an ordinary one-character atom.
