% Exercise: capstone — first-match-wins with a cascade of cuts
%
% In chapter 08 you classified a number with a CHAINED if-then-else
% (`sign/2`: positive / negative / zero). Cut gives you the other classic
% way to write "first matching case wins": one clause per case, each
% ending in `!`, with a catch-all last clause that needs no cut. The
% shape, in the abstract:
%
%     classify(X, first)  :- guard1(X), !.
%     classify(X, second) :- guard2(X), !.
%     classify(_, otherwise).
%
% Each clause is tried top to bottom. The first whose guard succeeds hits
% its cut and commits — the lower clauses never run. The final clause has
% no guard and no cut: it's the fallthrough when every guard failed.
% Without the cuts, the higher cases would also offer the lower answers
% on backtracking — the cuts are what make it a clean function from input
% to ONE result.
%
% Note the guards only test their OWN case, not a range: because the cut
% above already committed, by the time control reaches a lower clause you
% know every higher guard failed.
%
% Your task: define `grade(Score, Letter)`:
%   - `a` when Score >= 90
%   - `b` when Score >= 80
%   - `c` when Score >= 70
%   - `f` otherwise
% Use one clause per case with a cut, and a catch-all final clause.
%
% Delete the marker when done.

% I AM NOT DONE

% Define grade/2 here.



% Do not edit below this line

test :-
    grade(95, G1),
    G1 == a,
    grade(85, G2),
    G2 == b,
    grade(72, G3),
    G3 == c,
    grade(50, G4),
    G4 == f,
    grade(90, G5),
    G5 == a,
    findall(G, grade(85, G), L),
    L == [b].
