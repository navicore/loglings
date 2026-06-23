# Hint — 01-digit-sum

Two clauses. The base case fires when `N < 10`: a single digit is its own
sum, so the second argument is just `N` itself.

The recursive case (guard it with `N >= 10` so it doesn't overlap the base
case): take `Last is N mod 10` and `Rest is N // 10`, recurse on `Rest` to
get the sum of the leading digits, then add `Last` to that. The peeling
stops on its own — dividing by 10 each step eventually drops below 10.
