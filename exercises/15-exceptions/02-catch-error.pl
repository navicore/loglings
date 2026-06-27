% Exercise: catch an error the engine throws
%
% Last exercise you caught a ball YOU threw. But the engine throws balls too —
% every "error" you've bumped into in earlier chapters was really a throw you
% just never caught. Guarding `is/2` with `number/1` (chapter 12), keeping
% `atom_concat`'s arguments atoms (chapter 14), ordering goals so `is` never
% meets an unbound variable (chapter 01) — each was you stepping AROUND a throw.
% Now you can catch one instead.
%
% Engine errors all arrive in one standard shape, an ISO two-part term:
%
%     error(Formal, Context)
%
% `Formal` says what kind of error it is — that's the part you match on.
% `Context` is a human-readable atom describing it; you almost always ignore
% it with `_`. Some Formals you've already seen in passing:
%
%     instantiation_error                     % an argument was unbound
%     type_error(evaluable, foo)              % `foo` isn't arithmetic
%     evaluation_error(zero_divisor)          % you divided by zero
%     existence_error(procedure, foo/2)       % called an undefined predicate
%
% So dividing by zero throws `error(evaluation_error(zero_divisor), _)`. To
% catch exactly that and nothing else, your catcher names that Formal and
% leaves the context open:
%
%     catch(Goal, error(evaluation_error(zero_divisor), _), Recovery)
%
% Your task: define `safe_div(A, B, R)` — R is `A // B`, except that dividing
% by zero gives `R = 0` instead of blowing up. So `safe_div(10, 2, R)` gives
% `R = 5`, and `safe_div(7, 0, R)` gives `R = 0`.
%
% Note this is NOT the same as guarding with a `B =\= 0` test first — here you
% let the division run and catch the engine's own zero_divisor error. Match
% that specific Formal so a genuinely different error would still surface
% rather than being silently turned into 0.
%
% Delete the marker when done.

% I AM NOT DONE

% Define safe_div/3 here.



% Do not edit below this line

test :-
    safe_div(10, 2, A),
    A == 5,
    safe_div(7, 0, B),
    B == 0,
    safe_div(0, 5, C),
    C == 0,
    safe_div(-9, 3, D),
    D == -3.
