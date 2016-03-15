#!/bin/sh

if [ $# -lt "1" ]
then
  echo "Inf2D 2015/16 - Planner for Situation Calculus"
  echo "Usage: plan.sh [-debug] <filename> [<maximum plan length> | <minimum plan length> <maximum plan length>]"
  echo
  exit 1
fi

if [ "$1" = "-debug" ]
then
  DEBUG="assert(debug(on)),"
  shift
else
  DEBUG=""
fi

if [ ! -f "$1" ]
then
  echo "planner: cannot load \`$1': No such file"
  exit 1
fi

if [ -n "$3" ]
then
  if [ "$2" -le "$3" ] && [ "$2" -ge "0" ]
  then
    BOUNDS="($2,$3)"
  else
	echo "planner: invalid plan lenghts supplied"
	exit 1
  fi
else
  if [ -n "$2" ]
  then
    if [ "$2" -ge "0" ]
	then
  	  BOUNDS="($2)"
	else
	  echo "planner: invalid plan lenghts supplied"
	  exit 1
	fi
  else
	BOUNDS=""
  fi
fi 
   
echo "Inf2D 2015/16 - Planner for Situation Calculus"
echo

swipl -f planner.pl -g "${DEBUG}planner${BOUNDS}." -s "$1"
