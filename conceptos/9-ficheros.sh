#!/bin/bash

# Redirectores de canales
##  > Redirigir un determinado canal de salida a un sitio. 
#       Por defecto el estandar: stdout 
##  >> Redirigir un determinado canal de salida a un sitio
##     añadiendolo a lo que exista previamente en ese sitio. 
##      Por defecto el estandar: stdout 
##  < Redirigir al a un determinado canal de entrada. 
#       Por defecto el estandar: stdin

# Todo proceso tiene al menos 3 canales:
## stdout 1
## stderr 2
## stdin  0
# Uso básico
echo Hola                                   # Escribe hola donde? en la salida estandar: stdin
echo Hola > recursos/fichero.txt            # Escribe hola donde? en la salida estandar: stdout
read -n 1 -p "Pulsa cualquier tecla para continuar"
echo Más saludos >> recursos/fichero.txt    # Escribe más saludos donde? en la salida estandar: stdout
                                            # append
                                            
read -p "Dame un nombre: " nombre           # Leer el stdin hasta que reciba un salto de linea 
echo $nombre
read linea < recursos/fichero.txt
echo ____$linea

while read linea 
do
    echo +++$linea
done < recursos/fichero.txt

# Operadores para condiciones de ficheros:
# -d       Si un path existe y es un directorio
# -f       Si un path existe y es un fichero

directorio=recursos/
fichero=${directorio}fichero.txt

if [[ -d "$directorio" ]]; then
    echo "El directorio si existe,"
    if [[ -f "$fichero" ]]; then
        echo "El fichero si existe,"
        cat $fichero
    else
        echo "El fichero no existe, o no es un fichero"
    fi
else
    echo "El directorio no existe, o no es un directorio"
fi

