% Exercise: guarding arithmetic with a type test
%
% `is/2` is fussy: hand it anything that isn't a number and it doesn't fail
% quietly — it CRASHES the whole query with a runtime error:
%
%     ?- X is foo + 1.
%     error(type_error(evaluable, foo), ...)   % the query dies here
%
% So if you want to add up a list that might contain non-numbers mixed in
% with the numbers, you can't just `is` your way through it — the first
% stray atom blows up. You need to LOOK before you compute. `number/1` is
% that look:
%
%     ?- number(42).     % true
%     ?- number(3.14).   % true   (whole numbers and decimals both count)
%     ?- number(foo).    % false
%
% Your task: define `sum_nums(List, Sum)` — Sum is the total of just the
% numbers in List; anything that isn't a number is skipped. So
% `sum_nums([1, foo, 2, bar, 3], S)` gives `S = 6`, and a list with no
% numbers at all sums to 0.
%
% Without the guard, the recursive `is` would crash the moment it reached
% `foo`. With `number/1` deciding whether to add the head or skip it, the
% predicate stays total over messy input — that's the whole job of a type
% test: make a fussy operation safe to point at data you don't fully trust.
%
% Walk the list. Recurse first to total the tail, then use an if-then-else
% on `number(Head)` to either add the head or leave the running total alone.
%
% Delete the marker when done.

% I AM NOT DONE

% Define sum_nums/2 here.



% Do not edit below this line

test :-
    sum_nums([1, foo, 2, bar, 3], S1),
    S1 == 6,
    sum_nums([apple, banana], S2),
    S2 == 0,
    sum_nums([10, 20, 30], S3),
    S3 == 60,
    sum_nums([], S4),
    S4 == 0.
