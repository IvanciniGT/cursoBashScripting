#!bin/bash
# Al que gane 2

#                           JUGADOR
#.      ORDENADOR       Pi.    Pa.    Ti
#           Pi          0       1     2
#           Pa          2       0     1
#           Ti          1       2     0
#
# Empate.   0
# Jugador   1
# Ordenador 2
declare -A reglas
reglas[piedra,piedra]=0
reglas[piedra,papel]=2
reglas[piedra,tijera]=1
reglas[papel,piedra]=1
reglas[papel,papel]=0
reglas[papel,tijera]=2
reglas[tijera,piedra]=2
reglas[tijera,papel]=1
reglas[tijera,tijera]=0

opciones=( piedra papel tijera )
# Ordenador piensa que va a sacar
opcion_ordenador=$RANDOM%3  # 0 1 2
opcion_ordenador=${opciones[$opcion_ordenador]}  # 0 1 2
# Preguntamos al jugador piedra papel o tijera?
super_read \
    --prompt "Qué eliges" \
    --error-message "Debes elegir 'piedra', 'papel' o 'tijera'"\
    --retries 3 \
    --allowed-values-list "piedra papel tijera" \
    --question-mark "?" \
    opcion_jugador
# Calculamos el ganador
ganador=${reglas[$opcion_jugador,$opcion_ordenador]}