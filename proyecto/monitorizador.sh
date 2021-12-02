#!/bin/bash
. ./aux/super_menu.sh
. ./servicios.sh

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
function iniciarMonitorizacion(){
    echo
}
function pararMonitorizacion(){
    echo
}
function estadoServicios(){
    echo
}


super_menu "menus/principal"