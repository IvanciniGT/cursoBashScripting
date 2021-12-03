#!/bin/bash
. ./funciones.sh

declare -a monitorizacion_pids
#Iniciar Monitorización
function iniciarMonitorizacion(){ 
    monitorizacion_pids=()
    clear
    titulo "Iniciando monitorización de los servicios"
    for id_servicio in ${listado_servicios[@]}
    do
        local _url=$NOMBRE_ARRAY_SERVICIOS$id_servicio[url]
        local _descripcion=$NOMBRE_ARRAY_SERVICIOS$id_servicio[descripcion]
        echo "  Monitorizando servicio: ${id_servicio}: ${!_url}"
        iniciarComprobaciones ${!_url} 1 | volcarAFichero /tmp/$id_servicio.log  | identificarAlertas 5 /tmp/$id_servicio.status > /dev/null &
        monitorizacion_pids+=( $! )
    done
    azul $(linea)
    pausa
}
#Parar Monitorización
function pararMonitorizacion(){ 
    clear
    titulo "Deteniendo monitorización de los servicios"
    for monitorizacion_pid in ${monitorizacion_pids[@]}
    do
        kill -15 $monitorizacion_pid
    done
    azul $(linea)
    pausa
}
#Estado de los Servicios
function estadoServicios(){ 
    pantallaServicios &
    pantalla_pid=$!
    read -n 1
    kill -15 $pantalla_pid
}
