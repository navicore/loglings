% Exercise: a number's other text face — codes
%
% Last exercise you spelled a number into CHARACTERS with `number_chars/2` —
% a list of one-character atoms — because you were COMPARING digits (matching
% each against a target). Atoms compare cleanly; that was the right face.
%
% This time you're not comparing digits, you're ADDING them. And for that the
% other face is the natural one. `number_codes/2` spells a number into the
% character CODES — the integers that stand for those characters:
%
%     number_codes(425, Cs)     % Cs = [52, 50, 53]
%
% Those aren't the digits 4, 2, 5 — they're the codes for the characters '4',
% '2', '5'. The codes for the ten digits run in order from '0' = 48 up to
% '9' = 57. So a code is already a number, and the digit it stands for is just
% the code minus 48: `52 - 48 = 4`. Plain arithmetic, no conversion step.
%
% That's the whole reason both builtins exist. Same number, two faces:
%   - chars give you ATOMS — reach for them when you compare or rearrange the
%     written form (as you did counting digits).
%   - codes give you INTEGERS — reach for them when you compute on the digits,
%     because `Code - 48` is the digit's value for free.
%
% (Both run backwards too: `number_codes(N, [52, 50])` reads `N = 42` back.)
%
% Your task: define `digit_sum(N, S)` — S is the sum of the decimal digits of
% N (for N >= 0). So `digit_sum(1234, S)` gives `S = 10` (1 + 2 + 3 + 4), and
% `digit_sum(0, S)` gives `S = 0`.
%
% This is chapter 13's `digit_sum` again, reached through text instead of `//`
% and `mod`. Spell N into codes, then walk that list of codes with a small
% recursive helper that totals the digit values — the sum-a-list shape from
% exercise 01, where each element converts to its digit with `Code - 48`
% before it's added in. Empty list, zero total; otherwise convert the head,
% recurse on the tail, add.
%
% Delete the marker when done.

% I AM NOT DONE

% Define digit_sum/2 here (plus the helper it needs).



% Do not edit below this line

test :-
    digit_sum(0, A),
    A == 0,
    digit_sum(1234, B),
    B == 10,
    digit_sum(99, C),
    C == 18,
    digit_sum(2026, D),
    D == 10.
