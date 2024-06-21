#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

ALL_ELEMENTS_TABLE="
  SELECT 
    p.atomic_number AS properties_atomic_number,
    e.atomic_number AS elements_atomic_number,
    p.type_id AS properties_type_id,
    t.type_id AS types_type_id,
    p.atomic_mass,
    p.melting_point_celsius,
    p.boiling_point_celsius,
    e.symbol,
    e.name,
    t.type
  FROM
    properties p
  INNER JOIN
    elements e ON p.atomic_number = e.atomic_number
  INNER JOIN
    types t ON p.type_id = t.type_id
"

MAIN_MENU() {
  if [[ -z $1 ]]
  then
    echo Please provide an element as an argument.
  else
    #find element in database
    # checking if its a number or string
    if [[ $1 =~ ^[0-9]+$ ]];
    then
      FIND_ELEMENT_RESULT=$($PSQL "SELECT * FROM elements WHERE atomic_number = $1")
    else
      FIND_ELEMENT_RESULT=$($PSQL "SELECT * FROM elements WHERE symbol = '$1' OR name = '$1'")
    fi

    if [[ -z $FIND_ELEMENT_RESULT ]]
    then
      echo I could not find that element in the database.
    else
      echo $FIND_ELEMENT_RESULT | while read ELEMENT_ATOMIC_NUMBER BAR ELEMENT_SYMBOL BAR ELEMENT_NAME
      do
        echo hey
      done
    fi
  fi
}

MAIN_MENU $1