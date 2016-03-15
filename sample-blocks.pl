% ---------------------------------------------------------------------
%  ----- Informatics 2D - 2015/16 - Second Assignment - Planning -----
% ---------------------------------------------------------------------


% ------------------- Sample of a planning problem --------------------


% define the following predicate to print out extended information
% about the planning process at runtime. Will produce A LOT of text
% after the first 4-5 iterations, since it shows all the plans
% considered by the program!

debug(on).



% -- Include domain definitions from sample-blocks-domain.pl

:- ['sample-blocks-domain.pl'].




% -- Define the initial state: the necessary set of eternal predicates
% and fluents that describe the situation at the beginning of the run

heavy(table).				% cannot be moved

clear(blockA, s0).			% the only block with nothing on top

on(blockC, table, s0).
on(blockB, blockC, s0).
on(blockA, blockB, s0).




% -- Last, the goal condition that the planner will try to reach

goal(S) :- on(blockB, table, S).


% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
