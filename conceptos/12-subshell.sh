#!/bin/bash


utils/contador.sh A 5 20

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
( contar B 5 20 | totalizadorImpares ) &

echo Yo sigo haciendo cosas mientras el totalizado totaliza

# Los parentesis en bash:
# Definir arrays
# Agrupar expeesiones
# Ejecutar contenido en una subshell, tiene su propio entorno de variables (env)

$(ls /)

