% Exercise: arity (why we write `age/2`)
%
% The arity you ignored last time — the argument count — is not a detail.
% It is part of a predicate's IDENTITY. A functor name plus its arity is
% what Prolog uses to tell predicates apart, which is why you see things
% written `age/2`, `member/2`, `functor/3`: the number after the slash is
% the arity.
%
% The surprising consequence: `note/1` and `note/2` are TWO DIFFERENT
% predicates that merely share a name. Below, the one-argument `note`
% facts and the two-argument `note` facts live side by side and never
% interfere — arity keeps them apart.
%
% Your task, two small rules:
%   1. `arity_of(Term, N)` — N is Term's arity (use `functor/3`).
%   2. `freq(Name, Hz)` — look up the TWO-argument `note` for Name's Hz.
%
% Delete the marker when done.

% I AM NOT DONE

note(c).
note(d).
note(e).

note(c, 261).
note(a, 440).

% Define arity_of/2 and freq/2 here.



% Do not edit below this line

test :-
    arity_of(note(c), 1),
    arity_of(note(c, 261), 2),
    freq(c, 261),
    freq(a, 440).
