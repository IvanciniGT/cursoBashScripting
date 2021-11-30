# El ordenador piensa un numero
# El numero tiene que estar entre el 1 y el 20
# Y pregunta al usuario
# Tenemos 3 intentos para adivinarlo...
# A ver si ganamos

# Si la respuesta del usuario está a 1 a distancia: ESTA MUY CALIENTE
# 2 o 3 de distancia: ESTA CALIENTE
# 4 o 5 de distancia: ESTA FRIO
# 6 o + de distancia: ESTA CONGELADO

# Pongo a mi disposición el super_read y los formatos de colores
. ../proyecto/aux/super_read.sh

NUMERO_MAXIMO=20
VIDAS=3

function juegoAdivinarNumero(){
    clear
    # Pienso un numero entre el 1 y el NUMERO_MAXIMO
    let numero_a_adivinar=($RANDOM % $NUMERO_MAXIMO)+1
    # Bienvenida
    negrita "Juego de frio caliente®"
    echo
    echo He pensado un número...
    # Empiezo a preguntar
    for intento in $(seq 1 $VIDAS)
    do
        echo
        super_read \
            --prompt "Cuál crees que es" \
            --error-message "Debes introducir un número del 1 al $NUMERO_MAXIMO"\
            --retries 3 \
            --validation-pattern "^(([0])|([1-9][0-9]*))$" \
            --question-mark "?" \
            respuesta_jugador
        if (( $? == 0 )); then # El usuario ha dado una respuesta valida
            let diferencia=$numero_a_adivinar-$respuesta_jugador
            diferencia=${diferencia//-/} # Me como el menos
            case "$diferencia" in
                0)
                    verde "Has acertado. Enhorabuena!" 
                    echo
                    return
                ;;            
                1|2) 
                    amarillo "Uy!!! que te quemas"
                ;;
                3|4) 
                    amarillo "Calentito, calentito!"
                ;;
                4|5) 
                    azul "Tas lejos :("
                ;;
                5|6) 
                    morado "Buah! Pues no te falta"
                ;;
                *) 
                    turquesa "Casi mejor decicate a las matemáticas.. como adivino no tienes precio"
                ;;
            esac
        else # El usuario es un cafre no sabe escribir numeros
            error_fatal "Eres un cafre... paso de jugar contigo. Búscate amigos nuevos !"
            echo
            return 1
        fi
    done
    echo
    rojo "Lo siento, no lo adivinaste... El número era el: $numero_a_adivinar"
    echo
}

juegoAdivinarNumero