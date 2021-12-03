#!/bin/bash
. ./funciones.sh

declare -a monitorizacion_pids
#Iniciar Monitorización
function iniciarMonitorizacion(){ 
    monitorizacion_pids=()
    [[ $MODO_MONITORIZACION == "interactivo" ]] && clear
    [[ $MODO_MONITORIZACION == "interactivo" ]] && titulo "Iniciando monitorización de los servicios"
    
    # Si estoy en modo script.... que voy a mirar? 
    # Si tengo un fichero de pids... en ese caso, nada... es que ya los arranque antes
    for id_servicio in ${listado_servicios[@]}
    do
        local _url=$NOMBRE_ARRAY_SERVICIOS$id_servicio[url]
        local _descripcion=$NOMBRE_ARRAY_SERVICIOS$id_servicio[descripcion]
        echo "  Monitorizando servicio: ${id_servicio}: ${!_url}"
        iniciarComprobaciones ${!_url} 1 | volcarAFichero /tmp/$id_servicio.log  | identificarAlertas 5 /tmp/$id_servicio.status > /dev/null &
        monitorizacion_pids+=( $! ) 
        # Quiero persistencia de estos datos.... Si estoy en modo script
    done
    [[ $MODO_MONITORIZACION == "interactivo" ]] && azul $(linea)
    [[ $MODO_MONITORIZACION == "interactivo" ]] && pausa
}
#Parar Monitorización
function pararMonitorizacion(){ 
    [[ $MODO_MONITORIZACION == "interactivo" ]] && clear
    [[ $MODO_MONITORIZACION == "interactivo" ]] && titulo "Deteniendo monitorización de los servicios"
    
    # Leo los pids de un fichero (si estoy en modo script)
    # Una vez leidos que hago? con el fichero? borralo

    for monitorizacion_pid in ${monitorizacion_pids[@]}
    do
        kill -9 $monitorizacion_pid > /dev/null
    done
    
    [[ $MODO_MONITORIZACION == "interactivo" ]] && azul $(linea)
    [[ $MODO_MONITORIZACION == "interactivo" ]] && pausa
}
#Estado de los Servicios
function estadoServicios(){ 
    pantallaServicios &
    pantalla_pid=$!
    read -n 1
    kill -15 $pantalla_pid
}
