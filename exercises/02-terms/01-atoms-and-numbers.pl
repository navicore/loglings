% Exercise: atoms and numbers
%
% Everything you write in Prolog is a *term*. So far you've used two of
% the simplest kinds without naming them:
%
%   - an ATOM is a constant name, written in lowercase: `apple`, `red`,
%     `whiskers`. It stands only for itself.
%   - a NUMBER is what you'd expect: `42`, `7`, `-3`.
%
% They are genuinely different kinds of term — `apple` is not a number,
% and `42` is not an atom. Prolog gives you built-in tests to ask which
% is which:
%
%     atom(apple).     % succeeds
%     atom(42).        % fails
%     number(42).      % succeeds
%     number(apple).   % fails
%
% Your task: define `kind/2` so that `kind(Term, atom)` is true when Term
% is an atom, and `kind(Term, number)` is true when Term is a number.
% You'll want TWO clauses — one per kind — each guarded by the matching
% built-in test.
%
% Delete the marker when done.

% I AM NOT DONE

% Define kind/2 here (two clauses).



% Do not edit below this line

test :-
    kind(apple, atom),
    kind(42, number),
    kind(banana, atom),
    kind(7, number).
