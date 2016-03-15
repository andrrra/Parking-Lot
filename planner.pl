% ---------------------------------------------------------------------
%  ----- Informatics 2D - 2015/16 - Second Assignment - Planning -----
% ---------------------------------------------------------------------


% -------------= Simple planner for situation calculus =---------------
%
% Executes an iterative deepening search, by default limited to a depth
% of 15 levels
%
% plan.			will search for a plan of maximum length
% plan(M).      will search for a plan of maximum length up to M
% plan(N,M).    will search for a plan of mimimum length N and maximum
%               length M
%
%
% Checklist for the definition of a domain and problem:
%
% - initial state				initialize fluents in s0
%
% - possibility axioms			poss( <action>(...), S ) :- <precond>
%
% - successor-state axioms		<fluent>( ..., result(A,S) ) :-
%									<some events made it true>;	% or
%									<it was true all along>,	% and
%									not(<some events made it false>).
%
% - goal predicate				goal(S) :- <goal conditions>
%

% --------------------------= High Level =-----------------------------

% default number of iterations (15)
plan :- plan(0, 15).

% given max number of iterations
plan(MaxDepth) :- plan(0, MaxDepth).

% given min and max number of iterations
plan(MinDepth, MaxDepth) :-
  M is MaxDepth+1, write('Trying plans of length: '),
  plan(Plan, MinDepth, M), nl, nl, writePlan(Plan).



% same as above, to be called from shell; include additional output
% messages and halt to quit pl
planner :- planner(0, 15).
planner(MaxDepth) :- planner(0, MaxDepth).
planner(MinDepth, MaxDepth) :-
  nl, plan(MinDepth, MaxDepth), nl, halt;
  write('\n\nNo plan has been found!'), nl, nl, halt.



% ---------------------------= Low Level =-----------------------------

% start from depth N, up to M

plan(P, N, M) :-
  N < M,
  debugoutput(write('\n\nPlans of length ')),
  writef('%w %f',[N]),
  seqplan(P, N, s0), !.

plan(P, N, M) :- N < M, O is N+1, plan(P, O, M).

seqplan( [], N, S ) :- N = 0, debugoutput(writeSituation(S)), goal(S).
seqplan( [A|L], N, S) :- N > 0, M is N-1, result(A,S,S1), seqplan(L, M, S1).

result(E,S,result(E,S)) :- primitive_action(E), poss(E,S).

% -----------------------= Support Function =--------------------------

% debugoutput will be printed only if debug(on) is defined in the KB
:- dynamic debug/1.
:- multifile debug/1.

debug(off).
debugoutput(A) :- debug(on), A, !; true.


% prints a situation as a sequence of actions, starting from s0
writeSituation(s0) :- write('\n s0').
writeSituation(result(A,S)) :- writeSituation(S), writef(" > %w", [A]).

% prints a plan as a list of actions, numbered

writePlan(List) :-
  debugoutput(write('\nA plan has been found:\n\n')),
  writePlan(List,1).

writePlan([],_) :-
  nl.

writePlan([Action|List], Counter) :-
  writef('%3R %w\n',[Counter,Action]),
  Next is Counter+1,
  writePlan(List,Next).


% hides some (unimportant) warnings from the pl interpreter
:- style_check([-discontiguous, -singleton]).



% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
