#!/bin/bash
. ./aux/super_read.sh # Según POSIX

#servicios/servicios.txt
#
# [id de un servicio]
# descripcion=
# url=
#
DIRECTORIO_SERVICIOS=./servicios/
ARCHIVO_SERVICIOS=servicios.txt
NOMBRE_ARRAY_SERVICIOS=DATOS_SERVICIO_
# Para cada servicio vamos a crear un arrary asociativo, con 3 campos: id, descripcion, url

declare -a listado_servicios # aqui vamos a guardar los ids

function cargarServicios(){
    listado_servicios=()
    local id=""
    local descripcion=""
    local url=""
    
    while read linea 
    do
        if [[ -z "$linea" || "$linea" =~ "^\s*#" ]]; then # Si tienes espacios o tabuladores antes del #
            continue # salta a la siguiente iteracion
        elif [[ "$linea" == \[*\] ]]; then
            crearArrayServicio "$id" "$descripcion" "$url"
            id=${linea//\[/}
            id=${id//\]/}
            listado_servicios+=( "$id" )
        elif [[ "$linea" == *=* ]]; then
            campo=${linea%=*}
            valor=${linea#*=}
            #[[ "$campo" == "url" ]] && url="$valor"
            #[[ "$campo" == "descripcion" ]] && descripcion="$valor"
            eval $campo=\"$valor\"  # descripcion="esto es.." 
            
        fi
        
    done < ${DIRECTORIO_SERVICIOS}${ARCHIVO_SERVICIOS}
    crearArrayServicio "$id" "$descripcion" "$url"

}

function crearArrayServicio(){
    local id=$1
    if [[ -z "$id" ]]; then
        return
    fi
    local descripcion=$2
    local url=$3
    eval "declare -g -A ${NOMBRE_ARRAY_SERVICIOS}$id=([id]=\"$id\" [descripcion]=\"$descripcion\" [url]=\"$url\")"
                    # DATOS_SERVICIO_tomcat["url"]
                    # El parametro .g permite que la variable se cree globalmente
                    # Y por tanto pueda ser utilizada fuera de esta función
}

function altaServicio(){
    # Solicitar los datos del servicio
    clear
    titulo "Alta de servicio"
    super_read \
            --prompt "Id del servicio" \
            --error-message "Solo caracteres en minúscula" \
            --retries 3 \
            --validation-pattern "^[a-z]+$" \
            --question-mark ":" \
            ID_SERVICIO
    if [[ $? != "0" ]]; then
        error "Abortando..."
        pausa
        return 1
    fi
    super_read \
            --prompt "Descripción del servicio" \
            --retries 3 \
            --question-mark ":" \
            DESCRIPCION_SERVICIO
    super_read \
            --prompt "URL del servicio" \
            --error-message "URL no válida" \
            --retries 3 \
            --validation-pattern "^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$" \
            --question-mark ":" \
            URL_SERVICIO
    if [[ $? != "0" ]]; then
        error "Abortando..."
        pausa
        return 1
    fi
    # Guardar el servicio....en el archivo
    guardarServicio "$ID_SERVICIO" "$DESCRIPCION_SERVICIO" "$URL_SERVICIO"
    cargarServicios
    
    verde "Servicio creado correctamente"
    pausa
}
function guardarServicio(){
    local id=$1
    local descripcion=$2
    local url=$3
    echo >> ${DIRECTORIO_SERVICIOS}${ARCHIVO_SERVICIOS}
    echo "[$id]" >> ${DIRECTORIO_SERVICIOS}${ARCHIVO_SERVICIOS}
    echo "descripcion=$descripcion" >> ${DIRECTORIO_SERVICIOS}${ARCHIVO_SERVICIOS}
    echo "url=$url" >> ${DIRECTORIO_SERVICIOS}${ARCHIVO_SERVICIOS}
    
    
}
function bajaServicio(){
    clear
    titulo "Listado de servicios"
    super_read \
            --prompt "Id del servicio" \
            --error-message "Solo caracteres en minúscula" \
            --retries 3 \
            --validation-pattern "^[a-z]+$" \
            --question-mark ":" \
            ID_SERVICIO
    if [[ $? != "0" ]]; then
        error "Abortando..."
        pausa
        return 1
    fi
    echo > ${DIRECTORIO_SERVICIOS}${ARCHIVO_SERVICIOS}
    for id_servicio in ${listado_servicios[@]}
    do
        if [[ "$id_servicio" != "$ID_SERVICIO" ]]; then
            local _url=$NOMBRE_ARRAY_SERVICIOS$id_servicio[url]
            local _descripcion=$NOMBRE_ARRAY_SERVICIOS$id_servicio[descripcion]
            guardarServicio "$id_servicio" "${!_descripcion}" "${!_url}"
        fi
    done
    # Quitarla del fichero
        # Reescribir el fichero pero sin el que me interesa eliminar
    # Quitarla del array o recargar servicios
    cargarServicios
    verde "Servicio eliminado correctamente"
    pausa
}
function listarServicios(){
    [[ MODO_MONITORIZACION == "interactivo" ]] && clear                                               # Solo si estoy en modo interactivo
    [[ MODO_MONITORIZACION == "interactivo" ]] && titulo "Listado de servicios"                       #
    for id_servicio in ${listado_servicios[@]}
    do
        local _url=$NOMBRE_ARRAY_SERVICIOS$id_servicio[url]
        local _descripcion=$NOMBRE_ARRAY_SERVICIOS$id_servicio[descripcion]
        echo "${id_servicio}   ${!_url}  ${!_descripcion}"
    done
    [[ MODO_MONITORIZACION == "interactivo" ]] && azul $(linea)                                       #
    [[ MODO_MONITORIZACION == "interactivo" ]] && pausa                                               #
}

# Programa
# Lea el archivo de servicios... si existe...
if [[ ! -d "$DIRECTORIO_SERVICIOS" ]]; then
    mkdir -p $DIRECTORIO_SERVICIOS
fi
# Si no existe lo debe crear
if [[ ! -f "${DIRECTORIO_SERVICIOS}${ARCHIVO_SERVICIOS}" ]]; then
    touch "${DIRECTORIO_SERVICIOS}${ARCHIVO_SERVICIOS}"
else
    # Leerlo
    cargarServicios
fi