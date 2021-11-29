#!/bin/bash

# Comentarios

####################################################################################
# VARIABLES
####################################################################################
# 
# Una referencia un espacio en la memoria RAM donde guardamos datos. 
#

mi_variable=17
    # 17          -> Poner el texto 17 en la RAM
    # mi_variable -> Crear una variable (apuntador a la RAM)
    # =           -> Referenciar el número 17 (guardado en RAM) desde la variable.
mi_variable="23"
    # 23          -> El 23 a la RAM... donde? No donde estaba el 17... en otro sitio
    # =           -> Se mueve la ref de la variable al 23.
    
# Por defecto en la bash toda variable es un texto
# Admite otros tipos de variables... ya veremos

# Formas de asgnar valores a variables:
set mi_variable="23"
let mi_variable=23 # Esto funciona... pero no tiene mucho sentido

# Referenciar el valor de una variable

echo Mi variable vale: mi_variable
echo Mi variable vale: $mi_variablehola
echo Mi variable vale: $mi_variable.hola
echo Mi variable vale: ${mi_variable}hola

# Let permite indicar al SO que lo que viene detrás debe interpretarse como una expresión matemática
    # Si bien el resultado será un texto

set mi_variable=23+5
echo $mi_variable

# Indica a la bash que lo que hay detrás es una expresión matemática
let mi_variable=23+5  #Podemos poner + - * /
echo $mi_variable

####################################################################################
# Control de I/O
####################################################################################
# Volcar un texto en la salida estandar (u opcionalmente en otra)
echo "Repite el mensaje que pongo detrás en la salida indicada (stdout por defecto)"

echo "Primer echo"
echo -n "Segundo echo" # Al final de la linea no se añade un SALTO DE LINEA, 
                       # lo cúal se hace por defecto
echo "Tercer echo"

# Que canales de comunicación abre por defecto un proceso UNIX < POSIX
#   0   stdin       Entrada estandar
#   1   stdout      Salida estandar
#   2   stderr      Salida de error

# Leer datos desde un canal de entrada (por defecto el stdin)
echo "Escribe algo"
read nombre_de_una_variable
echo "Has escrito: $nombre_de_una_variable" # Interpolación de textos
echo 'Has escrito: $nombre_de_una_variable' # No se hace interpolación de textos

read -p "MENSAJE CON LA PREGUNTA: " variable_a_rellenar
echo "Has escrito: $variable_a_rellenar" # Interpolación de textos

read -n 2 -p "Pulse 2 teclas para continuar" # Indica cuantos caracteres son leidos
# Por defecto read lee hasta que se encuentra un SALTO DE LINEA