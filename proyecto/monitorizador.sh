#!/bin/bash
. ./aux/super_menu.sh
. ./servicios.sh
. ./monitorizar.sh
. ./comandos.sh

MODO_MONITORIZACION="script"
##
# Menu principal
#  1. Administrar Servicios
#  2. Monitorizar Servicios
#
#  0. Salir

# Elija una opción [2]: 

function administrarServicios(){
    super_menu "menus/administrar.servicios"
}
function monitorizarServicios(){
    super_menu "menus/monitorizar.servicios"
}
function salir(){
    clear
    echo "Gracias por utilizar el super monitorizador ACME®"
    exit 0
}

function volver(){
    echo
}

# No sabemos a priori si necesitamos lanzar el menu?
# Si no me pasan argumentos, lo anzo... pero si me pasan argumentos.... ummmm... ya no

if [[ -n "$1" ]]; then # Aqui debería venir algo como "service" o "monitoring"
    # comprobar si es un valor válido -> listado_comandos
    if [[ ! ( " ${listado_comandos[@]} " =~ " $1 " ) ]]; then
    # Si no está ahí dentro: EXPLOSION !!!!!!
        echo comando $1 incorrecto.
        exit 1
    else
    # Si si que está?
        if [[ -n "$2" ]]; then # Aqui debería venir algo como "service" o "monitoring"
            #echo ${!SUBCOMANDOS_service[@]}
            funcion=SUBCOMANDOS_$1[\"$2\"]
            #echo $funcion
            #echo ${!funcion}
            if [[ -n "${!funcion}" ]]; then
                ${!funcion} "$3" "$4" "$5" "$6"
            else
                echo comando $1 $2 incorrecto.
                exit 1
            fi
        # Comprobar que me han pasado un $2
            # Que no: EXPLOSION !!!!
            # Que si
                # Buscar el subcomando: $2 -> SUBCOMANDOS_$1["$2"] -> funcion que debo ejecutar
                    # Con qué argumentos? $3 $4 $5 
        else
            echo Falta el subcomando
            exit 1
        fi        
    fi        
else
    MODO_MONITORIZACION="interactivo"
    super_menu "menus/principal"
fi

