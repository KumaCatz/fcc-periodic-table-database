#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

MAIN_MENU() {
  if [[ -z $1 ]]
  then
    echo Please provide an element as an argument.
  else
    #find element in database
    ELEMENT_BY_ATOMIC_NUMBER=$($PSQL "SELECT * FROM properties INNER JOIN elements ON properties.atomic_number = elements.atomic_number INNER JOIN types ON properties.type_id = types.type_id WHERE atomic_number = $1")
    echo "$ELEMENT_BY_ATOMIC_NUMBER"
  fi
}

MAIN_MENU $1