#!/bin/bash

nombre=$1
maximo=$2
delay=$3

for numero in $(seq 1 $maximo)
do
    echo Soy: $nombre. Voy por: $numero
    sleep $delay
done
