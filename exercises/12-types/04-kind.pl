% Exercise: classifying any term — and why order matters
%
% The type tests so far each answered one yes/no question. Put several
% together and you can classify ANY term — decide what KIND of thing it is
% and dispatch on the answer. The tests you'll use:
%
%     atom(T)      % a name: hello, foo, []        (yes, [] is an atom)
%     number(T)    % 42, 3.5
%     is_list(T)   % a proper list: [a, b], []
%     compound(T)  % a term with arguments: point(1,2), [a,b], foo(X)
%
% Here's the catch that makes this more than four separate checks: these
% categories OVERLAP. The same term can answer `true` to more than one:
%
%                  atom   number   is_list   compound
%       hello       yes     no       no         no
%       42          no      yes      no         no
%       [a, b]      no      no       yes       YES   <- a list is compound!
%       point(1,2)  no      no       no         yes
%       []          yes     no      YES         no   <- atom AND is_list!
%
% So you can't just check them in any order and hope. If you tested
% `compound` before `is_list`, every list would come back "compound." You
% have to decide a PRIORITY and stop at the first test that fits — which is
% exactly what an if-then-else chain does.
%
% Your task: define `kind(Term, Kind)` where `Kind` is one of `number`,
% `atom`, `list`, or `compound` — the first one that fits, in that order.
% Read the overlap table to see why that order: `atom` before `is_list` so
% `[]` reports as an atom; `is_list` before `compound` so real lists report
% as lists rather than getting swept up as "compound."
%
% One clause, a single if-then-else chain (`( T1 -> ... ; T2 -> ... ; ... )`)
% walking the four tests in priority order. The chain commits to the first
% branch whose test succeeds — that commitment is what turns four
% overlapping yes/no tests into one clean classification.
%
% Delete the marker when done.

% I AM NOT DONE

% Define kind/2 here.



% Do not edit below this line

test :-
    kind(42, K1),
    K1 == number,
    kind(3.5, K2),
    K2 == number,
    kind(hello, K3),
    K3 == atom,
    kind([a, b, c], K4),
    K4 == list,
    kind(point(1, 2), K5),
    K5 == compound,
    kind([], K6),
    K6 == atom.
