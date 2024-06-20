#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"

MAIN_MENU() {
  if [[ -z $1 ]]
  then
    echo Please provide an element as an argument.
  else
    #find element in database
  fi
}

MAIN_MENU $1