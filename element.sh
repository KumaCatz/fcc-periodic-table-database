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
      FIND_ELEMENT_RESULT=$($PSQL "$ALL_ELEMENTS_TABLE WHERE e.atomic_number = $1")
    else
      FIND_ELEMENT_RESULT=$($PSQL "$ALL_ELEMENTS_TABLE WHERE e.symbol = '$1' OR e.name = '$1'")
    fi

    if [[ -z $FIND_ELEMENT_RESULT ]]
    then
      echo I could not find that element in the database.
    else
      echo "$FIND_ELEMENT_RESULT" | while IFS='|' read PROP_ATOMIC_NUMBER ELE_ATOMIC_NUMBER PROP_TYPE_ID TYPES_TYPE_ID ELE_ATOMIC_MASS MELTING_POINT_CELS BOILING_POINT_CELS ELE_SYMBOL ELE_NAME ELE_TYPE
      do
        echo -e "The element with atomic number $ELE_ATOMIC_NUMBER is $ELE_NAME ($ELE_SYMBOL). It's a $ELE_TYPE, with a mass of $ELE_ATOMIC_MASS amu. $ELE_NAME has a melting point of $MELTING_POINT_CELS celsius and a boiling point of $BOILING_POINT_CELS celsius."
      done
    fi
  fi
}

MAIN_MENU $1