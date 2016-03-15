% ---------------------------------------------------------------------
%  ----- Informatics 2D - 2015/16 - Second Assignment - Planning -----
% ---------------------------------------------------------------------
%
% Write here you matriculation number (only - your name is not needed)
% Matriculation Number: s1402967
%
%
% ------------------------- Domain Definition -------------------------
% This file describes a planning domain: a set of predicates and
% fluents that describe the state of the system, a set of actions and
% the axioms related to them. More than one problem can use the same
% domain definition, and therefore include this file


% --- Cross-file definitions ------------------------------------------
% marks the predicates whose definition is spread across two or more
% files
%
:- multifile at/3, parked/2, delivered/2.





% --- Primitive control actions ---------------------------------------
% this section defines the name and the number of parameters of the
% actions available to the planner
%
primitive_action( move(_,_,_) ).	% underscore means `anything'
primitive_action( park(_,_,_) ).
primitive_action( drive(_,_,_) ).
primitive_action( deliver(_,_) ).



% --- Precondition for primitive actions ------------------------------
% describe when an action can be carried out, in a generic situation S
%
poss( move(Agent, From, To), S ) :-		% implication poss() <= precond
  at(Agent, From, S),
  connected(From, To).

poss( park(Agent, Car, ParkingLot), S ) :-
  at(Agent, ParkingLot, S),
  at(Car, ParkingLot, S).
%  carState(Car, _, S).

poss( drive(Agent, Car, Y), S ) :-
  not(Agent = Car),
  at(Agent, X, S),
  at(Car, X, S),
  connected(X, Y).

poss( deliver(Agent, Car), S ) :-
  not(Agent = Car),
  at(Agent, PickUp, S),
  at(Car, PickUp, S).




% --- Successor state axioms ------------------------------------------
% describe the value of fluent based on the previous situation and the
% action chosen for the plan.
%
% fluent(..., result(A,S)) :- positive; previous-state, not(negative)

at(Agent, Location, result(A, S)) :-
  A = move(Agent, _, Location);
  not(A = move(Agent, _, Location)), at(Agent, Location, S).

parked(Car, result(A, S)) :-
  A = park(_, Car, ParkingLot), at(Car, ParkingLot, S);
  not(A = park(_, Car, _)), parked(Car, S).

%at(Car, ParkingLot, result(A,S)):-
%  A = park(Agent, Car, ParkingLot), at(Agent, ParkingLot, S);
%  not(A = park(Agent, Car, ParkingLot)), not(at(Agent, ParkingLot, S)), at(Car, ParkingLot, S).
%at(Car, Location, result(A, S)) :-
%  A = drive(_, Car, Location);
%  at(Car, Location, S), not(A = drive(_, Car, Location)).

%carState(Car, None, result(A, S)) :-
%  A = drive(_, Car, _);
%  not(A = drive(_, Car, _)), carState(Car, None, S).

delivered(Car, result(A, S)) :-
  A = deliver(_, Car);
  not(A = deliver(_, Car)), delivered(Car, S).




% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
