#!/bin/bash

# Montar una funcion: saluda
#   tipo de saludo: normal, formal, efusivo
#   Nombre al que saludar
# El resultado de la función saluda, lo guardais en una variable y lo imprimis por consola.
# Montains un programa que pida al usuario un tipo de saludo y un nombre a saludar...
# y lo usais para llamar a la funcion

function saluda(){
    TIPO_SALUDO=$1
    NOMBRE=$2
    # Elegimos la plantilla de saludo a utilizar
    SALUDO="Hola NOMBRE"
    case $TIPO_SALUDO in
        formal)
            SALUDO="Estimado NOMBRE"
        ;;
        efusivo)
            SALUDO="Hey NOMBRE!!!"
        ;;
    esac
    # Reemplazar el nombre en la plantilla y devolverlo
    echo ${SALUDO//NOMBRE/$NOMBRE}
}

# PROGRAMA:
TIPO_SALUDO="normal"
NOMBRE=""

while (( $# > 0 ))
do
    case "$1" in 
        -n|--nombre)
            NOMBRE=$2
            shift
            shift
        ;;
        -t|--tipo-saludo)
            TIPO_SALUDO=$2
            shift
            shift
        ;;
        *)
            echo "PARAMETRO DESCONOCIDO: $1"
            exit 1
        ;;
    esac
done
# Tomar los datos:
if [[ -z "$NOMBRE" ]]; then
    read -p "Dame un nombre: " NOMBRE
fi
#read -p "Dame un tipo de saludo (normal|efusivo|formal): " TIPO_SALUDO

# Componer el saludo
SALUDO=$(saluda $TIPO_SALUDO $NOMBRE)

# Mostrarlo por pantalla
echo "El saludo es: $SALUDO"


