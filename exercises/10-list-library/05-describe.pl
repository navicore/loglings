% Exercise: length/2 and last/2 (interrogate a list)
%
% Two more library predicates, both for asking a list about itself without
% taking it apart by hand:
%
%     length([a, b, c, d], N).    % N = 4   — how many elements
%     last([a, b, c, d], X).      % X = d   — the final element
%
% A note on `length/2` in plgc: use it to COUNT a list you already have
% (list bound, count comes back). The reverse direction — handing it a
% bound count and an unbound list to conjure a fresh list of that many
% variables — is not supported here and will run away; that's a compiler
% boundary, not something to lean on.
%
% Your task: define `describe(L, N, Last)` — bind N to the length of L and
% Last to its final element, in one rule. Just call the two library
% predicates on L.
%
% Delete the marker when done.

% I AM NOT DONE

% Define describe/3 here.



% Do not edit below this line

test :-
    describe([10, 20, 30], N, X),
    N == 3,
    X == 30,
    describe([a], N2, X2),
    N2 == 1,
    X2 == a.
