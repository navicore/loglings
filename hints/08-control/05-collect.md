# Hint — 05-collect

One rule, one goal in its body: a single `findall`. The worked example
showed that shape as a *query*; here you wrap the same shape in a rule so
`Genre` can arrive as an argument.

Ask the three findall questions:
  - What do you want to *keep* from each match? (that's the Template)
  - What makes something a match? (that's the Goal — a `book/2` lookup)
  - Where does the collected list go? (the third argument)

The genre isn't fixed — it's whatever the caller passes in, so it stays a
variable in your rule, used inside the goal. You don't filter the list
afterwards; the goal does the filtering as it searches.
