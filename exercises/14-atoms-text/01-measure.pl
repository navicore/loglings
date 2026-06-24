% Exercise: measuring an atom
%
% Until now an atom has been an opaque name — you could compare it (`==`),
% order it (`@<`), pass it around, but never look INSIDE it. The text
% predicates change that, and the simplest of them just measures: how many
% characters is this atom?
%
%     atom_length(penguin, N)     % N = 7
%     atom_length(hi, N)          % N = 2
%     atom_length('', N)          % N = 0   (the empty atom)
%
% That's the whole builtin: a relation between an atom and its length in
% characters. The first argument MUST be an atom — `atom_length` is not for
% numbers or lists.
%
% Your task: define `total_length(Atoms, N)` — N is the combined length of
% every atom in the list `Atoms`. So `total_length([cat, dog, fish], N)`
% gives `N = 10` (3 + 3 + 4), and the empty list totals 0.
%
% This is the sum-a-list shape from chapter 06, but instead of adding the
% numbers directly you first MEASURE each atom, then add. Base case: an empty
% list has total length 0. Recursive case: measure the head, recurse on the
% tail, add the two.
%
% One thing to watch — and it's a genuine Prolog surprise. Almost everywhere
% else, the ORDER of goals in a body doesn't change what's true; it only
% affects how the answer is found. `is/2` is the exception. It evaluates its
% right-hand side the instant control reaches it, so every variable on that
% side must ALREADY be bound by then. The recursive call is what binds the
% tail's total — so it has to run BEFORE the `is` that adds that total in.
% Put the `is` first, while the total is still an unbound variable, and you
% don't get a wrong answer — you get an `instantiation_error` and the query
% stops cold.
%
% So: produce a value before you consume it. This is the one corner where
% Prolog's "order doesn't matter" stops being true — `is/2` (and the
% arithmetic comparisons `<`, `=:=`, and friends) need their inputs computed
% already, and a goal that binds a variable has to come before the goal that
% uses it.
%
% Delete the marker when done.

% I AM NOT DONE

% Define total_length/2 here.



% Do not edit below this line

test :-
    total_length([], A),
    A == 0,
    total_length([hello], B),
    B == 5,
    total_length([cat, dog, fish], C),
    C == 10,
    total_length([a, bb, ccc], D),
    D == 6.
