#!/bin/bash

. $(dirname $BASH_SOURCE)/super_read.sh # Según POSIX


function super_menu(){
    local fichero_menu=$1
    
    local titulo
    local opcion
    declare -a opciones_menu
    declare -a funciones
    
    # Procesar el fichero del menu
    while read linea
    do
        echo "$linea"
        if [[ -z "$titulo" ]]; then
            titulo=$linea
        else
            opcion=${linea#*=}
            funcion=${linea%=*}
            opciones_menu+=( "$opcion" )
            funciones+=( "$funcion" )
        fi
    done < $fichero_menu.menu
    
    # Generar el menu
    while [[ "$opcion" != "0" ]]
    do
        clear
        titulo "$titulo"
        for ((i=1;i<${#opciones_menu[@]};i++))
        do
            echo "   $( amarillo $i ). ${opciones_menu[$i]}"
        done
        echo
        echo "   $( azul 0 ). ${opciones_menu[0]}"
        azul $(linea)
        
        super_read \
            --prompt "Elija una opción" \
            --error-message "Debe escribir el número de la opción elegida" \
            --retries 3 \
            --validation-pattern "^[0-${#opciones_menu[@]}]$" \
            --default 1 \
            --question-mark ":" \
            opcion
        
        ${funciones[$opcion]}
    done
}

