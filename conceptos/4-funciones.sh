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