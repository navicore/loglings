% Exercise 2: Multiple facts
%
% You can state any number of facts using the same name. Prolog will explore
% all of them when answering a query.
%
%     planet(mercury).
%     planet(venus).
%     planet(earth).
%
% Your task: add facts so that `primary/1` is true of each of the three
% primary colors — `red`, `blue`, and `yellow`.
%
% Delete the marker when done.

% I AM NOT DONE

% Add your primary color facts here:




% Do not edit below this line

:- dynamic(primary/1).
test :- primary(red), primary(blue), primary(yellow).
