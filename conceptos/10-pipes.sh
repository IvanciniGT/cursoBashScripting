#!/bin/bash

function contar(){
    local nombre=$1
    local maximo=$2
    local delay=$3
    
    for numero in $(seq 1 $maximo)
    do
        echo Soy: $nombre. Voy por: $numero
        sleep $delay
    done
}

#contar "A" 7 1 #> fichero.txt
#contar "A" 7 1    # Donde se mandan los datos? A la salida estandar stdout

function totalizadorImpares(){
    local total_numeros_impares=0
    while read linea 
    do
        numerito=${linea#*por: }
        if (( numerito % 2 == 1 )); then
            let total_numeros_impares=$total_numeros_impares+1
        fi
    done #< fichero.txt
        # De donde se leen los datos? De la entrada estandar
    
    echo En total hay $total_numeros_impares números impares.
}
function filtradorPequenos(){
    local min=$1
    while read linea 
    do
        numerito=${linea#*por: }
        if (( numerito >= $min )); then
            echo "$linea"
        fi
    done
    
}
# Ummm! Y se me ocurre... que pasaría si conecto la slida estandar
# de la primera función con la entrada estandar de la segunda?
# Eso es lo que hace un pipe.
# Los dos programas se estan ejecutando en paralelo
contar "A" 7 1 | filtradorPequenos 3 | totalizadorImpares

echo Hola