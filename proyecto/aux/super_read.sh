#!/bin/bash
#
# Función: super_read [args] var_name
#
# Argumentos:
#   -p, --prompt                texto   Mensaje que se muestra al usuario
#   -d, --default               texto   Valor por defecto
#   -q, --question-mark         texto   Delimitador de la pregunta. Por defecto ":"
#   -l, --allowed-values-list   texto   Valores posibles separados por espacios
#   -e, --error-message         texto   Mensaje si el valor introducido no es adecuado
#   -v, --validation-pattern    texto   Patrón que debe cumplir el valor introducido 
#   -r, --retries               numero  Número de intentos, si la respuesta es incorrecta
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
. $(dirname $BASH_SOURCE)/formatos.sh # Según POSIX
#source ./formatos.sh

MENSAJE_ERROR_POR_DEFECTO="Respuesta incorrecta"
QUESTION_MARK_POR_DEFECTO=":"
INTENTOS_POR_DEFECTO=3

function uso_incorrecto_de_la_funcion_superread(){ # Un fallo al usar la función
    echo "Uso incorreto de la función super_read"
    exit 1
}

function super_read(){
    # Definición de variables que necesita mi función
    local prompt=""                 # De serie dentro de una función definimos las variables como locales
    local default=""
    local questionmark=$QUESTION_MARK_POR_DEFECTO
    local varname=""
    local allowedvalueslist=""
    local errormessage="" #$MENSAJE_ERROR_POR_DEFECTO
    local validationpattern=""
    local retries=$INTENTOS_POR_DEFECTO
    
    # Captura de parametros
    while (( $# > 0 ))
    do
        case "$1" in 
            -r|--retries|-r=*|--retries=*)
                if [[ "$1" == *=* ]]; then
                    retries=${1#*=}
                else 
                    retries=$2
                    shift
                fi
            ;;
            -e|--error-message|-e=*|--error-message=*)
                if [[ "$1" == *=* ]]; then
                    errormessage=${1#*=}
                else 
                    errormessage=$2
                    shift
                fi
            ;;
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
            -l|--allowed-values-list|-l=*|--allowed-values-list=*)
                if [[ "$1" == *=* ]]; then
                    allowedvalueslist=${1#*=}
                else 
                    allowedvalueslist=$2
                    shift
                fi
            ;;
            -v|--validation-pattern|-v=*|--validation-pattern=*)
                if [[ "$1" == *=* ]]; then
                    validationpattern=${1#*=}
                else 
                    validationpattern=$2
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
    # TODO: Asegurarme que la variable retries contiene un numero mayor o igual a 1
    
    
    for numero_de_intento in $(seq 1 $retries)
    do
        
        # Mostrar la pregunta
        echo -n $prompt
        # Mostrar los posibles valores al usuario
        if [[ -n "$allowedvalueslist" ]]; then
            verde " ("
            valores_a_mostrar=""
            for valor_permitido in $allowedvalueslist
            do
                valores_a_mostrar="$valores_a_mostrar|$valor_permitido"
            done
            verde ${valores_a_mostrar#|}
            verde ")"
        fi
        
        # Mostrar el valor por defecto
        if [[ -n "$default" ]]; then
            amarillo " [$default]"
        fi
        echo -n "$questionmark "
        
        # Capturar la respuesta
        read respuesta_del_usuario
        
        # Validar esa respuesta
        # Revisar que si no se introduce nada y hay valor por defecto, se lo enchufo
        #respuesta_del_usuario=${respuesta_del_usuario:-$default}
        if [[ -z "$respuesta_del_usuario" && -n "$default" ]]; then
            respuesta_del_usuario="$default"
        fi
        
        respuesta_aceptable=0 # Respuesta aceptable
        
        # Validar si el valor está entre los permitidos
        if [[ -n "$allowedvalueslist" ]]; then
            respuesta_aceptable=1 # Respuesta no aceptable
            for valor_permitido in $allowedvalueslist
            do
                if [[ "$valor_permitido" == "$respuesta_del_usuario" ]]; then
                    respuesta_aceptable=0 # Respuesta aceptable
                    break # Rompe el bucle (for) para que ya no se siga procesando
                fi
            done
        fi
        # Validar si cumple con un patron que se haya suministrado
        if [[ -n "$validationpattern" ]]; then
            if [[ "$respuesta_del_usuario" =~ $validationpattern ]]; then
                respuesta_aceptable=0 # Respuesta aceptable
            else
                respuesta_aceptable=1 # Respuesta no aceptable
            fi
            #[[ "$respuesta_del_usuario" =~ $validationpattern ]] && respuesta_aceptable=0 || respuesta_aceptable=1 # Respuesta no aceptable
    
        fi
        
        if (( respuesta_aceptable == 0 )); then # Respuesta correcta
        # llegados el punto que la respuesta_del_usuario es válida, qué hago?
            # Relleno la variable $varname con el valor capturado
            eval $varname=\"$respuesta_del_usuario\" # -> eval IP="localhost"
            # EVAL: Primero resuelve variables para contruir una linea de codigo que posteriormente es ejecutada
            # EVAL es una función muy peligrosa. Sujeta a problemas de inyeccion de codigo
            #   IP=$(rm -rf /)
            return 0 # Ya tengo valor, me voy de la función
        else
            error "${errormessage:-$MENSAJE_ERROR_POR_DEFECTO}"
        fi
    done
    # TODO. En caso de que el usuario no sea capaz de dar un buen valor, le dejo la variable vacia
    eval $varname=\"\"
    return 1 # Salgo con error de la función
}

# Programa
#super_read -p="Dame la IP del servidor" --default localhost -e "Nombre de servidor incorrecto" IP 
#echo $IP
#super_read -p="Servicio a reiniciar" SERVICIO 
#echo $SERVICIO
#super_read --prompt "Deseas reiniciar el servidor" -d si -q "?" -l "si no" -e="Debe contestar 'si' o 'no'." REINICIO
#echo $REINICIO

#super_read \
#    --prompt "Segundos antes de reiniciar el servidor" \
#    -d 0 \
#    -v "^(([0-9])|([1-9][0-9]+))$" \
#    -e "Debe introducir un numero entero mayor o igual a cero" \
#    DELAY

