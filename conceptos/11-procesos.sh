#!/bin/bash

# Proceso? Una ejecución de un programa que tengo
# Un proceso tiene:
#   Canal de lectura estandar: 0 stdin
#   Canal de salida estandar:  1 stdout
#   Canal de salida errores  : 2 stderr
#   Tiene un identificador: pid

echo Voy a comenzar a contar

utils/contador.sh A 10 1 & # Abrir un proceso en paralelo con el mio
pid_contadorA=$!
utils/contador.sh B 20 1 & # Abrir un proceso en paralelo con el mio
pid_contadorB=$!


echo sigo por aqui
echo "y mientras el otro cuenta (Su pid es $pid_contadorA)"
echo yo quiero seguir haciendo cosas

#sleep 2
#echo Me quedé dormido... me aburro
#kill -9 $pid_contadorA
wait $pid_contadorA
estado=$?
[[ $estado == 0 ]] && echo A GUAY || echo A RUINA !!!
echo Hago cosas despues del A

wait $pid_contadorB
estado=$?
[[ $estado == 0 ]] && echo B GUAY || echo B RUINA !!!
echo Hago cosas despues del B