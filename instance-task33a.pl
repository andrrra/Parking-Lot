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

:- ['domain-task33.pl'].		% Replace with the domain for this problem




% --- Definition of the initial state ---------------------------------

connected(dropOff,parkingLot).
connected(parkingLot, dropOff).
connected(parkingLot, pickUp).
connected(pickUp, parkingLot).
car(carA).
car(carB).
car(carX).
car(carY).
agent(agent).
parkingLot(parkingLot).
pickUp(pickUp).
dropOff(dropOff).
keys(keysA).
keys(keysB).
slot(slot1).
slot(slot2).
slot(slot3).
slot(slot4).
occupied(slot1, carX, s0).
occupied(slot2, carY, s0).

keysToCar(keysA, carA).
keysToCar(keysB, carB).

at(carA, dropOff, s0).
at(carB, dropOff, s0).
at(agent, dropOff, s0).



% --- Goal condition that the planner will try to reach ---------------

goal(S) :- stored(keysB, parkingLot, S), stored(keysA, parkingLot, S).


% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
