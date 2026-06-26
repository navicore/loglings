% Exercise: counting a digit inside a number
%
% `atom_chars` (last exercise) spelled an ATOM into a list of characters.
% `number_chars/2` does the same for a NUMBER — it gives you the number's
% written form as a list of one-character ATOMS:
%
%     number_chars(2026, Cs)     % Cs = ['2', '0', '2', '6']
%
% Each element is an atom — the character '2', not the number 2. That's the
% point of this face: characters are atoms, so you compare them the way you
% compare any atoms, with `==` and `\==`. (It runs backwards too, reading a
% number out of a char list: `number_chars(N, ['4','2'])` gives `N = 42`.)
%
% Your task: define `count_digit(N, D, Count)` — Count is how many times the
% digit character D appears in the number N. D is a one-character atom like
% '0' or '7'. So `count_digit(2020, '0', Count)` gives `Count = 2`, and
% `count_digit(12345, '9', Count)` gives `Count = 0`.
%
% Spell N into its characters, then walk that list with a small recursive
% helper that counts matches. This is the walk-a-list shape from exercise 01,
% but instead of adding a measured length you add 1 only when the head
% character EQUALS D. An empty list holds no matches, so its count is fixed.
% For a non-empty list: count the tail, then add one to that total if the head
% is D and leave it unchanged otherwise — an if-then-else (`-> ;`, chapter 08)
% inside the body is a clean way to make that choice.
%
% Note you are COMPARING characters here, not doing arithmetic on them — which
% is exactly why the atom (char) face fits. The next exercise computes on the
% digits instead, and reaches for the other face.
%
% Delete the marker when done.

% I AM NOT DONE

% Define count_digit/3 here (plus the helper it needs).



% Do not edit below this line

test :-
    count_digit(2020, '0', A),
    A == 2,
    count_digit(2020, '2', B),
    B == 2,
    count_digit(12345, '9', C),
    C == 0,
    count_digit(7, '7', D),
    D == 1,
    count_digit(100, '0', E),
    E == 2.
