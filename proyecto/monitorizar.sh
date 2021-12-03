#!/bin/bash
. ./funciones.sh

declare -a monitorizacion_pids
#Iniciar Monitorización
function iniciarMonitorizacion(){ 
    monitorizacion_pids=()
    if [[ $MODO_MONITORIZACION == "interactivo" ]]; then
        clear
        titulo "Iniciando monitorización de los servicios"
    else
        # Si estoy en modo script.... que voy a mirar? 
        # Si tengo un fichero de pids... en ese caso, nada... es que ya los arranque antes
        if [[ -f "/tmp/monitorizacion.pids" ]]; then
            echo "La monitorización está en marcha. No hago nada"
            exit 0
        fi
    fi
    
    for id_servicio in ${listado_servicios[@]}
    do
        local _url=$NOMBRE_ARRAY_SERVICIOS$id_servicio[url]
        local _descripcion=$NOMBRE_ARRAY_SERVICIOS$id_servicio[descripcion]
        echo "  Monitorizando servicio: ${id_servicio}: ${!_url}"
        iniciarComprobaciones ${!_url} 1 | volcarAFichero /tmp/$id_servicio.log  | identificarAlertas 5 /tmp/$id_servicio.status > /dev/null &
        monitorizacion_pids+=( $! ) 
    done
    # Quiero persistencia de estos datos.... Si estoy en modo script
    if [[ $MODO_MONITORIZACION == "script" ]]; then
        echo ${monitorizacion_pids[@]} > /tmp/monitorizacion.pids
    fi

    [[ $MODO_MONITORIZACION == "interactivo" ]] && azul $(linea)
    [[ $MODO_MONITORIZACION == "interactivo" ]] && pausa
}
#Parar Monitorización
function pararMonitorizacion(){ 
    # Quiero persistencia de estos datos.... Si estoy en modo script
    if [[ $MODO_MONITORIZACION == "interactivo" ]]; then
        clear
        titulo "Deteniendo monitorización de los servicios"
    else
        # Leo los pids de un fichero (si estoy en modo script)
        # Una vez leidos que hago? con el fichero? borralo
        if [[ ! -f "/tmp/monitorizacion.pids" ]]; then
            echo "La monitorización NO está en marcha. No puedo parar"
            exit 10
        fi
        read pids < /tmp/monitorizacion.pids
        #echo $pids
        monitorizacion_pids=( $pids )
        #echo ${monitorizacion_pids[@]}
        rm -f /tmp/monitorizacion.pids
    fi
    

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
