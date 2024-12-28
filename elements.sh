#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

#DATABASE SEARCH FUNCTION

SEARCH(){
  #IF ARG PASSED
  if [[ $1 ]]
  then
  RESULT=$($PSQL "SELECT * FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id) WHERE $1;")

  #IF RESULT IS NON EMPTY
  if [[ $RESULT != '' ]]
  then

  echo $RESULT | while read TYPE_ID BAR ATOMIC_NUMBER BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR SYMBOL BAR NAME BAR TYPE
  do
  echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  done

  else

  echo I could not find that element in the database.

  fi
  fi
}

if [[ -z $1 ]]
then
echo "Please provide an element as an argument."
else

# check if arg is number 
if [[ $1 =~ ^[0-9]+$ ]]
then
SEARCH "atomic_number = $1"
fi

#check if arg is element letters
if [[ $1 =~ ^[A-Za-z]{1,2}$ ]]
then
SEARCH "symbol = '$1'"
fi

#check if arg is a whole word
if [[ $1 =~ ^[A-Za-z]{3,}$ ]]
then
SEARCH "name = '$1'"
fi

fi
