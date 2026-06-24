% Exercise: a number's two text faces — chars vs codes
%
% A number has more than one face. There's its VALUE, which arithmetic sees.
% And there's its written form, which comes in two flavours:
%
%   number_chars/2 spells a number into a list of one-character ATOMS:
%       number_chars(425, Cs)     % Cs = ['4', '2', '5']
%
%   number_codes/2 spells it into a list of character CODES (the integers
%   that stand for those characters — '0' is 48, '1' is 49, and so on):
%       number_codes(425, Cs)     % Cs = [52, 50, 53]
%
% Both run backwards too: give either one a list and it reads a number back
% out (`number_chars(N, ['4','2'])` gives `N = 42`).
%
% Why two? Because the pieces are different KINDS of thing, and that changes
% what you can do with them. A code is already a number, so the digit it
% stands for is just `Code - 48` — plain arithmetic. A char is an ATOM, so
% you can't subtract from it; to get its value you run `number_chars` the
% other way on that single char: `number_chars(V, ['4'])` gives `V = 4`.
%
% Your task: sum the decimal digits of N (for N >= 0) BOTH ways, and the
% chapter's point is that they agree.
%   digit_sum_chars(N, S) : spell N into char atoms, turn each char back into
%       its value with number_chars, and add them up.
%   digit_sum_codes(N, S) : spell N into codes, get each digit as Code - 48,
%       and add them up.
%
% Each needs a small recursive helper to walk its list and total the digit
% values — the sum-a-list shape once more, with a per-element conversion.
% This is chapter 13's `digit_sum` again, but reached through text instead of
% `//` and `mod` — and seen from both the atom side and the code side.
%
% Delete the marker when done.

% I AM NOT DONE

% Define digit_sum_chars/2 and digit_sum_codes/2 here
% (plus any helper predicates they need).



% Do not edit below this line

test :-
    digit_sum_chars(0, A),
    A == 0,
    digit_sum_chars(1234, B),
    B == 10,
    digit_sum_codes(1234, C),
    C == 10,
    digit_sum_codes(99, D),
    D == 18,
    digit_sum_chars(2026, E),
    digit_sum_codes(2026, F),
    E == F,
    E == 10.
