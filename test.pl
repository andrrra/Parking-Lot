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
car(carZ).
agent(agent).
parkingLot(parkingLot).
pickUp(pickUp).
dropOff(dropOff).
keys(keysA).
keys(keysB).
keysToCar(keysA, carA).
keysToCar(keysB, carB).
slot(slot1).
slot(slot2).
slot(slot3).
slot(slot4).

%occupied(slot1, carB, s0).
occupied(slot2, carX, s0).
occupied(slot3, carY, s0).
occupied(slot4, carZ, s0).

at(carA, dropOff, s0).
delivered(carB, s0).
%parked(carB, slot1, s0).
%stored(keysB, parkingLot, s0).
at(agent, dropOff, s0).
%dirty(carB, s0).




% --- Goal condition that the planner will try to reach ---------------
%goal(S) :- holding(agent, keysB, S), isClean(carB, S).
%goal(S) :- delivered(carB, S).
%goal(S) :- isClean(carA, S).
%goal(S) :- at(carB, pickUp, S).
%goal(S) :- not(occupied(slot1, carB, S)).
goal(S) :- parked(carA, slot1, S).

% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
