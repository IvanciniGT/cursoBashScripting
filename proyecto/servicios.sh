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
    echo
}
function listarServicios(){
    echo
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
    echo
fi
altaServicio