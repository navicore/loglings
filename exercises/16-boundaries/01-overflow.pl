% Exercise: integers have a ceiling (catchable overflow)
%
% This chapter is about the EDGES of the engine — the points where plgc says
% "no further". The first edge: integers are not unbounded. plgc stores them in
% 64 bits, so the largest is 9223372036854775807. Push a calculation past that
% and the engine does NOT silently wrap around (as C would) and does NOT grow
% the number without limit (as some Prologs do). It raises an error:
%
%     ?- X is 9223372036854775807 + 1.
%     error(evaluation_error(int_overflow), ...)
%
% That `error(...)` shape is the ISO one you met last chapter, and the good
% news is it's an ordinary catchable error — exactly like `zero_divisor`. So
% you can guard against it with `catch/3`.
%
% Below is `fact/2`, ordinary factorial. It grows fast: `fact(20, F)` is fine
% (about 2.4 x 10^18, just under the ceiling), but `fact(21, F)` overflows
% partway through its multiplications and throws `int_overflow`.
%
% Your task: define `safe_fact(N, F)` that runs `fact(N, F)` under a catch. On
% the normal path F is the factorial; if the computation overflows, catch it
% and let F be the atom `too_big` instead of crashing. Match the catcher on the
% error's shape — `error(evaluation_error(int_overflow), _)` — not on the
% culprit details.
%
%   safe_fact(5, F)    gives F = 120
%   safe_fact(20, F)   gives F = 2432902008176640000
%   safe_fact(21, F)   gives F = too_big
%
% Delete the marker when done.

% I AM NOT DONE

fact(0, 1).
fact(N, F) :- N > 0, N1 is N - 1, fact(N1, F1), F is N * F1.

% Define safe_fact/2 here.



% Do not edit below this line

test :-
    safe_fact(5, F5),
    F5 =:= 120,
    safe_fact(20, F20),
    F20 =:= 2432902008176640000,
    safe_fact(21, F21),
    F21 == too_big.
