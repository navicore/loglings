# Hint — 03-findall

`findall(Template, Goal, List)` collects *every* successful answer for `Goal`
into a list. The hidden test runs:

    findall(S, season(S), Seasons)

That means: "for every S that makes `season(S)` true, put S into Seasons."
Then the test asks that the resulting list have length 4.

So you need four `season/1` facts. Names are atoms (lowercase identifiers).
