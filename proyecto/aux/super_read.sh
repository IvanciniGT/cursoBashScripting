#!/bin/bash
#
# Función: super_read [args] var_name
#
# Argumentos:
#   -p, --prompt        texto   Mensaje que se muestra al usuario
#   -d, --default       texto   Valor por defecto
#   -q, --question-mark texto   Delimitador de la pregunta. Por defecto ":"
#
# Ejemplos:
#    Dame la IP del servidor [localhost]: ENTER
#       - Validar la IP
#            - Si no es válida? Mensaje, y probamos de nuevo (limitado a un numero de intentos)
#       - Valor por defecto
#       $ ./super_read.sh -p="Dame la IP del servidor" -d localhost  IP
#
#    Deseas reiniciar el servidor (si|no) [si]? tal vez
#       $ ./super_read.sh --prompt "Deseas reiniciar el servidor" -d si -q "?" REINICIO

function uso_incorrecto_de_la_funcion_superread(){
    echo "Uso incorreto de la función super_read"
    exit 1
}

function super_read(){
    # Definición de variables que necesita mi función
    local prompt=""                 # De serie dentro de una función definimos las variables como locales
    local default=""
    local questionmark=":"
    local varname=""
    
    while (( $# > 0 ))
    do
        case "$1" in 
            -p|--prompt|-p=*|--prompt=*)
                if [[ "$1" == *=* ]]; then
                    prompt=${1#*=}
                else 
                    prompt=$2
                    shift
                fi
            ;;
            -d|--default|-d=*|--default=*)
                if [[ "$1" == *=* ]]; then
                    default=${1#*=}
                else 
                    default=$2
                    shift
                fi
            ;;
            -q|--question-mark|-q=*|--question-mark=*)
                if [[ "$1" == *=* ]]; then
                    questionmark=${1#*=}
                else 
                    questionmark=$2
                    shift
                fi
            ;;
            -*)
                uso_incorrecto_de_la_funcion_superread
            ;;
            *)
                varname=$1
                if (( $# > 1 ));then
                    uso_incorrecto_de_la_funcion_superread
                fi
            ;;
        esac
        shift
    done
    
    # Ya tengo los argumentos leidos. 
    # Siguiente tarea: VALIDAR LOS ARGUMENTOS
    # Tengo garantía de que me hayan pasado un nombre de variable?
    if [[ -z "$varname" || -z "$prompt" ]]; then
        uso_incorrecto_de_la_funcion_superread
    fi
    
    # Mostrar la pregunta
    echo -n $prompt
    if [[ -n "$default" ]];then
        echo -n " [$default]"
    fi
        echo -n "$questionmark "
    
    # Capturar la respuesta
    read respuesta_del_usuario
    
    # Validar esa respuesta
    # Revisar que si no se introduce nada y hay valor por defecto, se lo enchufo
    if [[ -z "$respuesta_del_usuario" && -n "$default" ]]; then
        respuesta_del_usuario="$default"
    fi
    
    # llegados el punto que la respuesta_del_usuario es válida, qué hago?
    # Relleno la variable $varname con el valor capturado
    eval $varname=\"$respuesta_del_usuario\" # -> eval IP="localhost"
    # EVAL: Primero resuelve variables para contruir una linea de codigo que posteriormente es ejecutada
    # EVAL es una función muy peligrosa. Sujeta a problemas de inyeccion de codigo
    #   IP=$(rm -rf /)
    
}

# Programa
super_read -p="Dame la IP del servidor" --default localhost IP 
echo $IP
super_read -p="Servicio a reiniciar" SERVICIO 
echo $SERVICIO
super_read --prompt "Deseas reiniciar el servidor" -d si -q "?" REINICIO
echo $REINICIO
#super_read --prompt "Deseas reiniciar el servidor" -d si -REINICIO
