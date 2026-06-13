% Exercise: putting control together
%
% No new operators here — this is the chapter-05 "choosing" drill again,
% now for control. Three small predicates about a traffic light; each
% one is most naturally written with a DIFFERENT construct you just
% learned. Decide which fits each job:
%
%   - if-then-else  ( C -> T ; ... )   — pick one result from several cases
%   - disjunction   ( A ; B )          — true when either holds
%   - negation      \+ G               — true when something is NOT the case
%
% Your tasks:
%
%   1. action(Light, A): A is `stop` for red, `slow` for yellow, `go`
%      for anything else. (One result per case -> which construct?)
%
%   2. warn(Light): true when Light is red OR yellow. (Either holds.)
%
%   3. crossable(Light): true when the light's action is NOT `stop`.
%      (Reuse `action/2` — you defined it in task 1.)
%
% Delete the marker when done.

% I AM NOT DONE

% 1. action(Light, A): stop / slow / go.
% action(Light, A) :- ...

% 2. warn(Light): red or yellow.
% warn(Light) :- ...

% 3. crossable(Light): action is not stop.
% crossable(Light) :- ...



% Do not edit below this line

test :-
    action(red, stop),
    action(yellow, slow),
    action(green, go),
    warn(red),
    warn(yellow),
    \+ warn(green),
    crossable(green),
    crossable(yellow),
    \+ crossable(red).
