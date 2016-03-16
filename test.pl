% debug(on).	% need additional debug information at runtime?

% --- Load domain definitions from an external file -------------------
:- ['domain-task32.pl'].		% Replace with the domain for this problem
% --- Definition of the initial state ---------------------------------

connected(dropOff,parkingLot).
connected(parkingLot, dropOff).
connected(parkingLot, pickUp).
connected(pickUp, parkingLot).
parkingLot(parkingLot).
pickUp(pickUp).
dropOff(dropOff).
agent(agent).
car(car).
keys(keys).
keysToCar(keys, car).

at(agent, dropOff, s0).
at(car, parkingLot, s0).
parked(car, s0).
dirty(car, s0).
%holding(agent, keys, s0).

stored(keys, parkingLot, s0).

%parked(car, s0).

% --- Goal condition that the planner will try to reach ---------------
%goal(S) :- stored(keys, parkingLot, S).
%goal(S) :- holding(agent, keys, S).
%goal(S) :- at(car, pickUp, S).
goal(S) :- delivered(car, S).
% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
