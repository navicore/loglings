% Exercise: ; (disjunction — inline "or")
%
% You already know one way to say "or": write two clauses with the same
% head. Prolog can also say it INLINE, inside a single clause body, with
% the `;/2` operator:
%
%     ( GoalA ; GoalB )
%
% succeeds if GoalA succeeds, OR (on backtracking) if GoalB succeeds.
% Read the semicolon as "or". The comma is still "and"; `;` binds looser
% than `,`, and you almost always wrap the whole thing in parentheses so
% the reader groups it the way you mean:
%
%     pet(X) :- ( X = cat ; X = dog ).
%
% That single clause behaves exactly like the two-clause version
% `pet(cat).  pet(dog).` — including offering BOTH answers on
% backtracking.
%
% Your task: define `weekend(Day)` true when Day is `saturday` or
% `sunday`, using ONE clause with `;`.
%
% Delete the marker when done.

% I AM NOT DONE

% Define weekend/1 here.



% Do not edit below this line

test :-
    weekend(saturday),
    weekend(sunday),
    \+ weekend(monday),
    findall(D, weekend(D), Days),
    Days == [saturday, sunday].
