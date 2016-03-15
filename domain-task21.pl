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
%  Agent = agent,
  at(Agent, From, S),
  connected(From, To).

poss( park(Agent, Car, Location), S ) :-
  Location = parkingLot,
%  Agent = agent,
  at(Agent, Location, S),
  at(Car, Location, S).

poss( drive(Agent, Car, Y), S ) :-
%  Agent = agent,
  at(Agent, X, S),
  at(Car, X, S),
  connected(X, Y).

poss( deliver(Agent, Car), S ) :-
%  Agent = agent,
  Location = pickUp,
  at(Agent, Location, S),
  at(Car, Location, S).




% --- Successor state axioms ------------------------------------------
% describe the value of fluent based on the previous situation and the
% action chosen for the plan.
%
% fluent(..., result(A,S)) :- positive; previous-state, not(negative)

at(Agent, Location, result(A, S)) :-
  A = move(Agent, _, Location);
  A = drive(Agent, _, Location);
  at(Agent, Location, S), not(A = move(Agent, Location, _)), not(A = drive(Agent, _, _)).

at(Car, Location, result(A, S)) :-
  A = drive(_, Car, Location);
  at(Car, Location, S), not(A = drive(_, Car, _)).

parked(Car, result(A, S)) :-
  A = park(_, Car, _);
  parked(Car, S), not(A = park(Agent, Car, _)), not(A = drive(Agent, Car, _)).

delivered(Car, result(A, S)) :-
  A = deliver(_, Car);
  delivered(Car, S), not(A = deliver(_, Car)).




% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
