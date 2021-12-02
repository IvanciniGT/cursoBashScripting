#!/bin/bash

#   Canal de lectura estandar: 0 stdin
#   Canal de salida estandar:  1 stdout
#   Canal de salida errores  : 2 stderr

echo HOLA # Vuelca en salida Estandar
echo HOLA > ./fichero.txt
echo HOLA 1> ./fichero.txt
        # Donde vuelca el echo? En su salida estandar
        # La salida estandar la redirijo a un fichero
        
#              entrada estandar
#            |-------|v|-------|
#            -                 ------------------------
#salida err <      echo        > salida estandar -  FICHERO
#            -                 ------------------------
#            |---------| |-----|


function mifuncion(){
    echo Salida error 1>&2 # Escribe por la salida estandar... que he engañado y 
                    # te la he enchufado a la de error el agujero de la salida de error
    echo Salida estandar
}

mifuncion 1>> ./fichero.txt  2>> ./fichero.txt
mifuncion 1> ./fichero.txt  2>&1

exec 3<> fichero2.txt # Abri un fichero en modo lectura/escritura

echo HOLA >&3

read -n 4 linea <&3

echo ----$linea

exec 3>&- # Cierro el fichero 