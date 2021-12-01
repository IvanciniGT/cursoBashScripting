#!/bin/bash
##
# Menu principal
#  1. Administrar Servicios
#  2. Monitorizar Servicios
#
#  0. Salir

# Elija una opción [2]: 

# funcion  Administrar servicios: echo "Estoy en AS"
# funcion  Monitorizar servicios: echo "Estoy en MS"
. $(dirname $BASH_SOURCE)/super_read.sh # Según POSIX

function administrarServicios(){
    echo "Estoy en administrar servicios"
    pausa
}
function monitorizarServicios(){
    echo "Estoy en monitorizar servicios"
    pausa
}
function salir(){
    echo "Gracias por utilizar el super monitorizador ACME®"
    exit 0
}

function super_menu(){
    while true
    do
        clear
        titulo "Menú principal"
        echo "   1. Administrar Servicios"
        echo "   2. Monitorizar Servicios"
        echo
        echo "   0. Salir"
        azul $(linea)
        
        super_read \
            --prompt "Elija una opción" \
            --error-message "Debe escribir el número de la opción elegida" \
            --retries 3 \
            --validation-pattern "^[0-2]$" \
            --default 1 \
            --question-mark ":" \
            opcion
        
        funciones=( salir administrarServicios monitorizarServicios )
        ${funciones[$opcion]}
    done
}

super_menu