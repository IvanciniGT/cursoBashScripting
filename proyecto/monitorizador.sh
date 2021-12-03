#!/bin/bash
. ./aux/super_menu.sh
. ./servicios.sh
. ./monitorizar.sh
. ./comandos.sh

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

super_menu "menus/principal"