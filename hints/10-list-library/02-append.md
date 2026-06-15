# Hint — 02-append

You can't append three lists in one call — `append/3` takes exactly two
inputs. So do it in two steps: append Subj and Verb into a temporary
(give it a name like `SV`), then append Obj onto that temporary to get S.

The middle variable is the trick: it's the output of the first append and
an input to the second.
