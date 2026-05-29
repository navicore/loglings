% Solution: 02-multiple-facts

primary(red).
primary(blue).
primary(yellow).

% Do not edit below this line

:- dynamic(primary/1).
test :- primary(red), primary(blue), primary(yellow).
