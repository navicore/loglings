# Hint — 03-split

"Prefix is a leading segment of List" means: List is Prefix followed by
some leftover. So call `append` with Prefix as the front, an anonymous
`_` as the back (you don't care what's left over), and List as the whole.

One goal, no recursion. If you're tempted to walk the list element by
element, step back — append already knows how to match a front.
