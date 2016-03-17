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

:- ['domain-task21.pl'].		% Replace with the domain for this problem




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
dropOff(dropOff).
at(agent, dropOff, s0).
at(carA, parkingLot, s0).
at(carB, dropOff, s0).
parked(carA, s0).




% --- Goal condition that the planner will try to reach ---------------

goal(S) :- parked(carB, S), delivered(carA, S), at(agent, dropOff, S).




% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
