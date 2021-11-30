#!/bin/bash

# Ya hemos usado arrays
# OPCION 1: array=(item1 item2 item3)
# OPCION 2: declare -a array
#           array[0]=item1
#           array[1]=item2
#           array[2]=item3
# ${array[1]}
#
#
# En los arrays asociativos, los valores no van identificacos por su posicion, sino por una palabra
# Es el equivalente en otros lenguajes de programación: MAPA o un DICCIONARIO
# OPCION 1: 
declare -A array=([clave1]=item1 [clave1]=item2 [clave1]=item3)
# OPCION 2: 
declare -A array
echo ${array["clave1"]}
array["clave1"]="Otro valor"
echo ${array["clave1"]}
