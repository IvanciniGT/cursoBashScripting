#!/bin/bash

function contar1(){
#    for numero in "1 2 3 4 5 6 7 8 9 "
#    for numero in {1..20..2}
#    for numero in $(seq 1 2 20)
    for (( numero=1; numero<21; numero++ ))
    do
        echo $numero
    done
}

contar1


# Bucles basados en una condicion
## While
## Until

function contar2(){
    NUMERO_ACTUAL=1
    while (( $NUMERO_ACTUAL <= 20 ))
    do
        echo $NUMERO_ACTUAL
        let NUMERO_ACTUAL=$NUMERO_ACTUAL+1
    done
    echo ___$NUMERO_ACTUAL
}
contar2


function contar3(){
    NUMERO_ACTUAL=1
    until (( $NUMERO_ACTUAL > 20 )) # La condicion es la contraria al while
    do
        echo $NUMERO_ACTUAL
        let NUMERO_ACTUAL=$NUMERO_ACTUAL+1
    done
    echo ___$NUMERO_ACTUAL
}
contar3