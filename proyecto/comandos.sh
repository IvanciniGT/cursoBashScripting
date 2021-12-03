#!/bin/bash

DIRECTORIO_COMANDOS=./comandos/
ARCHIVO_COMANDOS=comandos.txt
NOMBRE_ARRAY_COMANDOS=SUBCOMANDOS_

declare -a listado_comandos

# declare -a listado_comandos=(service monitoring)
# declare -A SUBCOMANDOS_service=( [create]:altaServicio [delete]:bajaServicio [list]:listarServicios )
# declare -A SUBCOMANDOS_monitoring=( [start]:iniciarMonitorizacion [stop]:pararMonitorizacion [status]:estadoServicios )

function cargarComandos(){
    listado_comandos=()
    local id=""
    local subcomando=""
    local funcion=""
    
    while read linea 
    do
        if [[ -z "$linea" || "$linea" =~ "^\s*#" ]]; then # Si tienes espacios o tabuladores antes del #
            continue # salta a la siguiente iteracion
        elif [[ "$linea" == \[*\] ]]; then
            id=${linea//\[/}
            id=${id//\]/}
            listado_comandos+=( "$id" )
            eval "declare -g -A ${NOMBRE_ARRAY_COMANDOS}$id"
                # declare -g -A SUBCOMANDOS_service
        elif [[ "$linea" == *=* ]]; then
            subcomando=${linea%=*}
            funcion=${linea#*=}
            eval ${NOMBRE_ARRAY_COMANDOS}$id[\"$subcomando\"]=\"$funcion\" 
                # SUBCOMANDOS_service["create"]=altaServicio
        fi
        
    done < ${DIRECTORIO_COMANDOS}${ARCHIVO_COMANDOS}

}

cargarComandos