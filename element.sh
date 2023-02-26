#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
    echo "Please provide an element as an argument."
    exit
fi

input=$1

if [[ ! $input =~ ^[0-9]+$ ]]
then
    letter=$($PSQL "SELECT * FROM properties left join elements using(atomic_number) left join types using(type_id) WHERE symbol = '$input' OR name = '$input'")

    if [[ -z $letter ]]
    then
        echo "I could not find that element in the database."
        exit
    else
        echo "$letter" | while IFS='|' read TYPE_ID ATOMIC_NUMBER ATOMIC_MASS MELTING_POINT BOILING_POINT SYMBOL NAME TYPE
        do
            echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
        done
    fi
else
    number=$($PSQL "SELECT * FROM properties left join elements using(atomic_number) left join types using(type_id) WHERE atomic_number=$input")

    if [[ -z $number ]]
    then
        echo "I could not find that element in the database."
        exit
    else
        echo "$number" | while IFS='|' read TYPE_ID ATOMIC_NUMBER ATOMIC_MASS MELTING_POINT BOILING_POINT SYMBOL NAME TYPE
        do
            echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
        done
    fi
fi

