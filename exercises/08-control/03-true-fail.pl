% Exercise: true and fail (the two simplest goals)
%
% Everything to the right of `:-` is a GOAL — something Prolog proves. You've
% been writing goals all along, but always *compound* ones: `parent(tom, X)`,
% `N > 0`, `member(X, L)`. Here's the piece that was never said out loud: a
% bare atom is ALSO a goal. Written on its own in a body, an atom is a call to
% the predicate of that name and zero arguments — `foo` means "prove `foo/0`".
%
% `true` and `fail` are two such predicates, built into the language:
%
%     true    always succeeds (and binds nothing)
%     fail    always fails
%
% They are not keywords and not booleans — Prolog has no boolean type. They are
% ordinary atoms that happen to name two zero-arity predicates the engine
% already defines for you. Nothing magic: that's exactly why only `true` and
% `fail` work where a "do-nothing" goal is wanted. Put some other atom there,
% say `haha`, and Prolog tries to call `haha/0`, finds no such predicate, and
% throws `existence_error(procedure, haha/0)`.
%
% You already know `true`, in fact — it's been hiding in every fact you wrote.
% A fact is shorthand for a rule whose body is `true`:
%
%     light(green).            is exactly    light(green) :- true.
%
% Where do these earn their keep? As a branch that should "just succeed" or
% "just fail". Recall the if-then-else chain from the last exercise: its
% fall-through can be a bare `true` (succeed, do nothing), and a branch can be
% `fail` to reject a case outright.
%
% Your task: define three predicates.
%
%   always   — succeeds always. Its body is the single goal `true`.
%   never    — fails always. Its body is the single goal `fail`.
%   open(Door) — a door defaults to OPEN, except the `vault`, which is closed.
%                Use an if-then-else: if the door is the vault, `fail`;
%                otherwise `true`. So open(front) succeeds, open(vault) fails.
%
% Note `open/1` can't be a table of facts: every door but one succeeds, and
% you can't list every possible door. The `true` fall-through is what says
% "anything not singled out is fine" — its real job.
%
% Delete the marker when done.

% I AM NOT DONE

% Define always/0, never/0, and open/1 here.



% Do not edit below this line

test :-
    always,
    \+ never,
    open(front),
    open(side),
    open(garden),
    \+ open(vault).
