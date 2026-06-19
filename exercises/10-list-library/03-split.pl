% Exercise: append/3 run BACKWARDS (the relational "aha")
%
% Here is what sets Prolog apart from ordinary functions. `append/3` isn't
% a one-directional "join" — it's a RELATION between three lists, and you
% can leave different arguments unbound to run it different ways.
%
% Bind only the WHOLE list and ask for the parts, and append becomes a
% list-splitter. Every way to cut the list in two is a solution:
%
%     append(Front, Back, [1, 2, 3]).
%       % Front=[],      Back=[1,2,3]
%       % Front=[1],     Back=[2,3]
%       % Front=[1,2],   Back=[3]
%       % Front=[1,2,3], Back=[]
%
% And if you bind the whole list plus a KNOWN front, it peels that front
% off and hands you the rest:
%
%     append([1], Back, [1, 2, 3]).     % Back = [2, 3]
%
% Same predicate as last exercise — only the bindings changed. One
% definition, many modes.
%
% Your task: use this to define `starts_with(List, Prefix)` — true when
% Prefix is a leading segment of List. Think relationally: List is Prefix
% followed by SOMETHING (you don't care what that something is).
%
% Delete the marker when done.

% I AM NOT DONE

% Define starts_with/2 here.



% Do not edit below this line

test :-
    starts_with([1, 2, 3, 4], [1, 2]),
    starts_with([a, b], [a, b]),
    starts_with([x, y, z], []),
    \+ starts_with([1, 2, 3], [2, 3]),
    \+ starts_with([1], [1, 2]).
