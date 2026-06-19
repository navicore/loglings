% Exercise: capstone — between/3 as an integer generator
%
% `between(Low, High, X)` relates X to the integers from Low to High
% (inclusive). Like `member`, it has two faces:
%
%   * As a TEST, X bound: `between(1, 5, 3)` succeeds (3 is in range).
%   * As a GENERATOR, X unbound: `between(1, 5, X)` yields 1, 2, 3, 4, 5
%     on backtracking — a stream of integers with no list to write out.
%     (If Low > High there are simply no solutions.)
%
% That generator pairs naturally with `findall/3` from chapter 00: let
% `between` produce the numbers, and add a test in the goal to keep only
% the ones you want — exactly the "generate and test" shape Prolog is
% built for.
%
% Your task: define `even_range(Lo, Hi, L)` — L is the list of all EVEN
% integers between Lo and Hi (inclusive), in order. Use `findall` over a
% `between` generator, with an evenness test on each number. (Recall from
% chapter 01 that `0 is X mod 2` holds exactly when X is even.)
%
% Delete the marker when done.

% I AM NOT DONE

% Define even_range/3 here.



% Do not edit below this line

test :-
    even_range(1, 10, L),
    L == [2, 4, 6, 8, 10],
    even_range(2, 2, One),
    One == [2],
    even_range(3, 3, None),
    None == [].
