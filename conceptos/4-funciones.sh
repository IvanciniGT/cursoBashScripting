#!/bin/bash

# FUNCIONES
# Qué es una función?
## Un trozo de código que podemos onvocar (ejecutar) posteriormente a su definición, en múltiples ocasiones
## Reutilizar código
## Tener el código más organizado ***** 

# Las funciones pueden recibir argumentos
# Las funciones pueden devolver un codigo de salida, igual que los procesos
    # Por defecto el codigo de salida de una funcion es 0. Lo podría explicitar:
        # return CODIGO_DALIDA
        # Ojo con el exit: EXIT sale del programa... con un código de salida

# Creación / definición de una función en la bash:
function saluda(){ # En los parentesis en la BASH no se pone NADA
    # Codigo de la funcion
    echo "HOLA"
    return 1
    # Ojo, return no sirve para que una función devuelva un valor... 
    #    Sino que corta la ejecución y da un CODIGO DE SALIDA
}

# Para invocar/ejecutar la funcion
saluda
saluda
saluda
echo "la funcion terminó con código $?"

# Para usar los parametros:
# $1 para el primer argumento
# $2 para el segundo argumento
# $119 para el 119avo argumento

# Pra saber el numero de argumentos que tengo: $#
# CUIDADO:
# $0:    El nombre la terminal
function saludaPersonalizado(){ # En los parentesis en la BASH no se pone NADA
    # Codigo de la funcion
    echo "HOLA $1"
    echo "(Me has pasado $# argumentos)"
}

saludaPersonalizado "Ivan" "Otro argumento" 4

# Como hago entonces para capturar lo que devuelve una función?

#Dado un numero, devuelve el doble del numero
function doblar(){
    #echo "ME LLEGA >>>> $1"
    let doble="$1 * 2"
    echo "$doble"
}


variable=$( doblar 5 )
echo "El doble del numero 5 es $variable"

#$( comando )  Ejecuta un comando en una subshell y captura la salida estandar del comando

ficheros=$( ls / )


function lectorArgumentos(){
    echo $1.   # a
    shift   # Descartar el primer argumento de entre los argumentos que recibe una función o programa
            # Se ha descartado el $1... Por lo tanto:
                # $2 -> $1
    echo $1
    echo $2
    echo $3
    echo $4
    echo $5
    echo Tienes: $# argumentos
}
lectorArgumentos a b c d e

# 1 a     -> shift  ->      b         
# 2 b                       c
# 3 c                       d
# 4 d                       e
# 2 e


function movermePorArgumentos(){
    TOTAL_ARGUMENTOS=$#
    for indice_argumento in $(seq 1 $TOTAL_ARGUMENTOS)
    do
        echo ---${!indice_argumento} # Devolver el valor de una variable cuyo nombre
                                    # esta contenido en otra variable
    done
}
movermePorArgumentos a b c d e

azul=4
rojo=16

color="azul"

echo ${!color}  # AZUL ---> 4 ????

function movermePorArgumentos2(){
    while (( $# > 0 )) # Mientras haya argumentos
    do
        echo +++$1      # Imprimo el primero
        shift           # Y lo descarto
    done
}
movermePorArgumentos2 a b c d e