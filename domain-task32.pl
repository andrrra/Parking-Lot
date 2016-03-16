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
:- multifile at/3, parked/2, delivered/2, agent/1, car/1, pickUp/1, parkingLot/1, dirty/2, isClean/2, keys/1, keysToCar/2, holding/3, stored/3.




% --- Primitive control actions ---------------------------------------
% this section defines the name and the number of parameters of the
% actions available to the planner
%
primitive_action( move(_,_,_) ).	% underscore means `anything'
primitive_action( park(_,_,_) ).
primitive_action( drive(_,_,_,_) ).
primitive_action( deliver(_,_) ).
primitive_action( clean(_,_) ).
primitive_action( grab(_,_,_,_) ).
primitive_action( store(_,_,_,_) ).




% --- Precondition for primitive actions ------------------------------
% describe when an action can be carried out, in a generic situation S
%
poss( move(Agent, From, To), S ) :-		% implication poss() <= precond
  agent(Agent),
  at(Agent, From, S),
  connected(From, To).

poss( park(Agent, Car, Location), S ) :-
  parkingLot(Location),
  agent(Agent),
  car(Car),
  at(Agent, Location, S),
  at(Car, Location, S).

poss( drive(Agent, Car, Keys, Y), S ) :-
  agent(Agent),
  car(Car),
  at(Agent, X, S),
  at(Car, X, S),
  keys(Keys),
  keysToCar(Keys, Car),
  connected(X, Y),
  holding(Agent, Keys, S).

poss( deliver(Agent, Car), S ) :-
  agent(Agent),
  car(Car),
  pickUp(Location),
  at(Agent, Location, S),
  at(Car, Location, S),
  isClean(Car, S).

poss( clean(Agent, Car), S ) :-
  agent(Agent),
  car(Car),
  dirty(Car, S).

poss( grab(Agent, Keys, Car, ParkingLot), S ) :-
  car(Car),
  agent(Agent),
  keys(Keys),
  keysToCar(Keys, Car),
  parkingLot(ParkingLot),
  at(Agent, ParkingLot, S),
  stored(Keys, ParkingLot, S),
  not(holding(Agent,_,S)).

poss( store(Agent, Keys, Car, ParkingLot), S ) :-
  car(Car),
  agent(Agent),
  keys(Keys),
  keysToCar(Keys, Car),
  parkingLot(ParkingLot),
  at(Agent, ParkingLot, S),
  parked(Car, S),
  holding(Agent, Keys, S).


% --- Successor state axioms ------------------------------------------
% describe the value of fluent based on the previous situation and the
% action chosen for the plan.
%
% fluent(..., result(A,S)) :- positive; previous-state, not(negative)

at(Who, Location, result(A, S)) :-
  (
    (
      agent(Who),
      (
        A = move(Who, _, Location);
        A = drive(Who, _, _, Location);
        (
          at(Who, Location, S),
          not(A = move(Who, Location, _)),
          not(A = drive(Who, _, _, _))
        )
      )
    );
    (
      car(Who),
      (
        A = drive(_, Who, _, Location);
        (
          at(Who, Location, S),
          not(A = drive(_, Who, _, _))
        )
      )
    )
  ).

parked(Car, result(A, S)) :-
  (
    car(Car),
    (
      A = park(_, Car, _);
      (
        parked(Car, S),
        not(A = park(Agent, Car, _)),
        not(A = drive(Agent, Car, _, _))
      )
    )
  ).

delivered(Car, result(A, S)) :-
  (
    car(Car),
    (
      A = deliver(_, Car);
      (
        delivered(Car, S),
        not(A = deliver(_, Car))
      )
    )
  ).

isClean(Car, result(A, S)) :-
  (
    car(Car),
    (
      A = clean(_, Car);
      (
        isClean(Car, S),
        not(A = clean(_, Car)),
        not(A = park(_, Car, _))
      )
    )
  ).

dirty(Car, result(A, S)) :-
  (
    car(Car),
    (
      A = park(_, Car, _);
      (
        parked(Car, S),
        not(A = park(_, Car, _)),
        not(A = drive(_, Car, _, _)),
        not(A = deliver(_, Car))
      )
    )
  ).

holding(Agent, Keys, result(A, S)) :-
  (
    agent(Agent), keys(Keys),
    (
      A = grab(Agent, Keys, _, _);
      (
        holding(Agent, Keys, S),
        not(A = grab(Agent, Keys, _, _)),
        not(A = store(Agent, Keys, _, _))
      )
    )
  ).

stored(Keys, ParkingLot, result(A, S)) :-
  (
    keys(Keys), parkingLot(ParkingLot),
    (
      A = store(_, Keys, _, ParkingLot);
      (
        stored(Keys, ParkingLot, S),
        not(A = store(_, Keys, _, ParkingLot)),
        not(A = grab(_, Keys, _, ParkingLot))
      )
    )
  ).

% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
