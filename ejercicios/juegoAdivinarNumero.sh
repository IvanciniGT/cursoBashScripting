# El ordenador piensa un numero
# El numero tiene que estar entre el 1 y el 10
# Y pregunta al usuario
# Tenemos 3 intentos para adivinarlo...
# A ver si ganamos

# Pongo a mi disposición el super_read y los formatos de colores
. ../proyecto/aux/super_read.sh

NUMERO_MAXIMO=10
VIDAS=3

function juegoAdivinarNumero(){
    clear
    # Pienso un numero entre el 1 y el NUMERO_MAXIMO
    let numero_a_adivinar=($RANDOM % $NUMERO_MAXIMO)+1
    # Bienvenida
    negrita "Juego de adivinar un número®"
    echo
    echo He pensado un número...
    echo
    # Empiezo a preguntar
    for intento in $(seq 1 $VIDAS)
    do
        super_read \
            --prompt "Cuál crees que es" \
            --error-message "Debes introducir un número del 1 al $NUMERO_MAXIMO"\
            --retries 3 \
            --validation-pattern "^(([0])|([1-9][0-9]*))$" \
            --question-mark "?" \
            respuesta_jugador
        if (( $? == 0 )); then # El usuario ha dado una respuesta valida
            if [[ "$numero_a_adivinar" == "$respuesta_jugador" ]]; then # El usuario SI ha acertado
                verde "Has acertado. Enhorabuena!" 
                echo
                return
            else # El usuario no ha acertado
                amarillo "Ese no es..."
                echo
            fi
        else # El usuario es un cafre no sabe escribir numeros
            error_fatal "Eres un cafre... paso de jugar contigo. Búscate amigos nuevos !"
            echo
            return 1
        fi
    done
    rojo "Lo siento, no lo adivinaste... El número era el: $numero_a_adivinar"
    echo
}

juegoAdivinarNumero