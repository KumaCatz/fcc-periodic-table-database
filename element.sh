#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

ALL_ELEMENTS_TABLE="
  SELECT 
    p.atomic_number AS properties_atomic_number,
    e.atomic_number AS elements_atomic_number,
    p.type_id AS properties_type_id,
    t.type_id AS types_type_id,
    p.type,
    p.atomic_mass,
    p.melting_point_celsius,
    p.boiling_point_celsius,
    e.symbol,
    e.name,
    p.type
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
    ELEMENT_BY_ATOMIC_NUMBER=$($PSQL "$ALL_ELEMENTS_TABLE WHERE p.atomic_number = 1")
    echo "$ELEMENT_BY_ATOMIC_NUMBER"
  fi
}

MAIN_MENU $1