#!/bin/bash

function comprobarURL(){
    response_code=$(curl -o /dev/null -s -L -w '%{http_code}' "$1")
    echo $response_code
}

function iniciarComprobaciones(){
    local URL=$1
    local INTERVALO=$2
    while true
    do
        response_code=$(comprobarURL "$URL")
        echo $response_code
        sleep $INTERVALO
    done
}
function volcarAFichero(){
    local FICHERO=$1
    while read linea 
    do
        echo "$(date +%H:%M:%S) - $linea" >> $FICHERO
        echo "$linea"
    done
}

function identificarAlertas(){
    local MAXIMO_FALLOS_CONSECUTIVOS=$1
    local FICHERO=$2
    local fallos_consecutivos_actual=0
    local mensaje=""
    while read linea 
    do
        if [[ "${linea}" =~ ^2 ]]; then
            let fallos_consecutivos_actual=0
            mensaje=OK
        else
            let fallos_consecutivos_actual=$fallos_consecutivos_actual+1
            (( "$fallos_consecutivos_actual" >= "$MAXIMO_FALLOS_CONSECUTIVOS" )) && mensaje=ALERT || mensaje=WARNING
        fi
        echo $mensaje > $FICHERO
        echo $linea
    done
}

#trap funcion_propia SIGTERM
# docker run --name minginx --rm -p 8080:80 -d nginx
# docker stop minginx
read -n 1 -p "Pulse una tecla tecla comenzar y en cualquier momento otra para finalizar"
iniciarComprobaciones "http://localhost:8080/" 1 | volcarAFichero localhost.log  | identificarAlertas 5 url1.status > /dev/null &
comprobador_pid_1=$!
iniciarComprobaciones "http://localhost:8081/" 1 | volcarAFichero localhost2.log | identificarAlertas 5 url2.status > /dev/null &
comprobador_pid_2=$!


while true
do
    clear
    echo "http://localhost:8080    $(cat url1.status)"
    echo "http://localhost:8081    $(cat url2.status)"
    sleep 4
done

read -n 1

kill -15 $comprobador_pid_1
kill -15 $comprobador_pid_2
#----------------------------------
#TASA REFRESCO SEA DE 4 segundos 
#URL1: OK| WARNING | ALERTA
#URL2: OK| WARNING | ALERTA
#------------------------------------
