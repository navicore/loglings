% Exercise: compound terms
%
% A COMPOUND TERM is a functor (a name) plus one or more arguments:
%
%     age(ann, 9)        % functor `age`, arguments `ann` and `9`
%     point(3, 4)        % functor `point`, arguments `3` and `4`
%
% Every fact you've written is a compound term. And just as you build
% them, you can take them apart with two built-ins:
%
%     functor(Term, Name, Arity)   % Name is the functor, Arity the arg count
%     arg(N, Term, A)              % A is the Nth argument (1-based)
%
% For example:
%
%     functor(age(ann, 9), F, A).  % F = age, A = 2
%     arg(1, age(ann, 9), X).      % X = ann
%
% Your task: define `describe(Term, Name, First)` so that Name is Term's
% functor and First is its first argument. (You won't need the arity
% here — call it `_Arity` and ignore it. You'll use it in the next
% exercise.)
%
% Delete the marker when done.

% I AM NOT DONE

% Define describe/3 here.



% Do not edit below this line

test :-
    describe(age(ann, 9), age, ann),
    describe(point(3, 4), point, 3).
