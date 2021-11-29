#!/bin/bash
# Para montar un array/lista en bash, tenemos dos opciones:

## ÑAPOSA, pero eficaz y muy comoda, pero muy simple en cuanto a funcionalidad
colores="rojo azul verde"
echo $colores

# Bucle para procesar cada uno de los valores
for color in $colores
do
    # Codigo a realizar para cada color
    echo $color
done

## Hasta aquí la funcionalidad de la forma ñaposa

## FORMAL, más funcionalidad... pero es mucho más incomoda

#colores=(rojo azul verde) # Esto ya no un texto... es una lista
colores=( $colores )                                        # Convertimos un texto en una lista
echo $colores # UPS SOLO EL PRIMERO !... esto ya no carbura
echo ${colores[@]} # Esto es guay !!!!                        Transforma una lista en texto

for color in ${colores[@]}
do
    # Codigo a realizar para cada color
    echo $color
done

echo ${colores[0]} 
echo ${colores[1]} 
echo ${colores[2]} 

unset colores[1] # Sigo teniendo una lista con 3 posiciones... pero la segunda no tiene valor asignado
echo ${colores[0]} 
echo ${colores[1]} 
echo ${colores[2]} 

colores[2]="amarillo"
echo ${colores[0]} 
echo ${colores[1]} 
echo ${colores[2]} 

declare -a superheroes
superheroes[0]="Ironman"
superheroes[1]="Capitan américa"
superheroes[2]="Thor"

for superheroe in "${superheroes[@]}" # NOTA, sin las comillas, 
                                      # si hay elementos con espacios, se toman como varios elementos, 
                                      # cada palabra de un elemento
do
    # Codigo a realizar para cada color
    echo $superheroe
done

echo ${#superheroes[@]}      # numero de elementos en el array
for (( indice=0; indice<${#superheroes[@]}; indice++ ))
do
    echo ${superheroes[$indice]}
done