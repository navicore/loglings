% Exercise: telling integers from floats
%
% `number/1` lumps all numbers together, but Prolog keeps two distinct
% numeric types, and sometimes the difference matters: `3` (an integer) and
% `3.0` (a float) are NOT the same term, even though they compare equal
% arithmetically. Two tests tell them apart:
%
%     ?- integer(3).     % true        ?- float(3).     % false
%     ?- integer(3.0).   % false       ?- float(3.0).   % true
%
% Side by side: every number answers `true` to exactly one of them. `42`
% is an integer; `2.5` is a float; `number/1` would say yes to both.
%
% Your task: define `split_num(List, Ints, Floats)` — given a list of
% numbers, sort them into two lists: `Ints` gets the integers, `Floats`
% gets the floats, each in their original order. So
% `split_num([1, 2.5, 3, 4.0], Is, Fs)` gives `Is = [1, 3]` and
% `Fs = [2.5, 4.0]`.
%
% This is the filtering idea from chapter 11, but routing each element into
% one of two buckets instead of keeping or dropping it. One clause per
% destination: when the head is an integer it goes on the front of `Ints`;
% when it's a float it goes on the front of `Floats`. The type test on the
% head is what chooses the bucket.
%
% Delete the marker when done.

% I AM NOT DONE

% Define split_num/3 here.



% Do not edit below this line

test :-
    split_num([1, 2.5, 3, 4.0], Is, Fs),
    Is == [1, 3],
    Fs == [2.5, 4.0],
    split_num([], E1, E2),
    E1 == [],
    E2 == [].
