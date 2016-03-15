% ---------------------------------------------------------------------
%  ----- Informatics 2D - 2015/16 - Second Assignment - Planning -----
% ---------------------------------------------------------------------


% -------------------- Sample of a planning domain --------------------


% the following line specifies which predicates or fluents are defined
% across two or more files. These predicates appear here, and in the
% initial state and goal definitions, in sample-blocks.pl

:- multifile on/3, clear/2.		% <name>/<number of parameters>




% -- Primitive control actions: this section defines the name and
% the number of parameters of the actions available to the planner

primitive_action( move(_,_) ).	% underscore means `anything'




% -- Preconditions for primitive actions: describe when an action
% can be carried out, in a generic situation S

poss( move(What, Where), S ) :-		% implication poss() <= precond
  clear(What, S),
  clear(Where, S),
  not(heavy(What)),			% can't move the table (or other heavy obj)
  not(What = Where),		% can't move a block on top of itself
  not(on(What, Where, S)).	% can't move around the same support
  							% (applies for the table)



% -- Successor State Axioms for primitive fluents: describe the value
% of fluent based on the previous situation and the action chosen for
% the plan.

% The general form of a successor state axiom is:
%
% a fluent is true in the situation resulting from applying action A
% in situation S, if
%   - action A makes the fluent true; OR
%   - the fluent was already true in the previous situation S,
%       AND action A will not change this fact, by making it false.


on(Block, Support, result(A, S)) :-
  A = move(Block, Support);
  on(Block, Support, S), not(A = move(Block, _)).


clear(table, _).	% special case, the table is clear any situation
					% (i.e. there is always space on the table)

clear(Block, result(A, S)) :-
  A = move(Something, _), on(Something, Block, S);
  not(A = move(_, Block)), clear(Block, S).


% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
