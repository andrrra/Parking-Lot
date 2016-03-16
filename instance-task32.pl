% ---------------------------------------------------------------------
%  ----- Informatics 2D - 2015/16 - Second Assignment - Planning -----
% ---------------------------------------------------------------------
%
% Write here you matriculation number (only - your name is not needed)
% Matriculation Number: s1402967
%
%
% ------------------------- Problem Instance --------------------------
% This file is a template for a problem instance: the definition of an
% initial state and of a goal.

% debug(on).	% need additional debug information at runtime?



% --- Load domain definitions from an external file -------------------

:- ['domain-task32.pl'].		% Replace with the domain for this problem




% --- Definition of the initial state ---------------------------------

connected(dropOff,parkingLot).
connected(parkingLot, dropOff).
connected(parkingLot, pickUp).
connected(pickUp, parkingLot).
car(carA).
car(carB).
agent(agent).
parkingLot(parkingLot).
pickUp(pickUp).
keys(keysA).
keys(keysB).

keysToCar(keysA, carA).
keysToCar(keysB, carB).

at(carA, parkingLot, s0).
parked(carA, s0).
dirty(carA, s0).
stored(keysA, parkingLot, s0).

at(carB, dropOff, s0).

at(agent, dropOff, s0).
holding(agent, keysB, s0).




% --- Goal condition that the planner will try to reach ---------------

goal(S) :- delivered(carA, S), stored(keysB, parkingLot, S).




% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
