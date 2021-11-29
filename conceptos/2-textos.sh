#!/bin/bash

mi_texto="En un lugar de la mancha de cuyo nombre no quiero acordarme..."

echo $mi_texto
echo ${mi_texto}

# Extraccion de textos
                # Posición de inicio de la extracción
echo ${mi_texto:6:5}
                  # Cuantos caracteres extraer
                  
                  # Contamos desde atrás... antepenultimo
echo ${mi_texto: -3:3}
                # OJO A ESE ESPACIO EN BLANCO AL PONER UN SIGNO MENOS. ES IMPORTANTE
                
# Cuantos caracteres tenemos
echo El texto tiene ${#mi_texto} caracteres   

# Quita el prefijo
echo ${mi_texto#En un lugar}

# Quita el sufijo
echo ${mi_texto%...}

# En los dos anteriores podemos usar caracteres comodin: *
echo ${mi_texto%lugar*}
echo ${mi_texto#*lugar}

# Valor por defecto
#mi_textito="Un valor previo"
echo ${mi_textito:-"VALOR por defecto de mi variable"}

# Reemplazamiento de textos
nombre="Ivan APELLIDO"
apellido="Osuna"

nombre_real=${nombre//APELLIDO/$apellido}

# Convertir mayusculas/minusculas
echo $nombre_real
echo ${nombre_real,,} # Convertir a minusculas
echo ${nombre_real^^} # Convertir a myusculas
echo ${nombre_real~~} # Invertir case
