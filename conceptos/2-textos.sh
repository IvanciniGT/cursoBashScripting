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

# Patrones de Expresiones regulares. Sintaxis PERL
# TEXTO                 PATRON                           LO CUMPLE?         Sintaxis PERL
# Hola amigo            contiene la palabra amigo           √                   amigo
# Hola amigo            empieza por la palabra amigo        x                   ^amigo
# Hola amigo            acaba por la palabra amigo          √                   amigo$
# 918894722             Contiene solo digitos               √                   ^[0-9]+$
# 918894722             Contiene 2 ochos seguidos           √                   8{2}

# Sintaxis PERL.   NOTA: regex101 EN GOOGLE
#        ^ BLOQUES $    
# ^ Opcional, indica "empieza por"
# $ Opcional, indica "acaba por"
# | Or

# BLOQUE:   secuencia_de_caracteres Factor_de_repeticion
# Secuencia de caracteres
#   amigo                           literalmente "amigo"
#   .                               cualquier caracter
#   [amigo]                         cualquier caracter de entre los suministrados
#   [0-9]                           cualquier digito
#   [a-z]                           cualquier letra minuscula ASCII
#   [A-Z]                           cualquier letra minuscula ASCII
#   [0-9a-zA-ZñÑçáÓ]                cualquier letra minuscula ASCII

# Factores de repetición:
# NADA                              Debe aparecer 1 vez
# ?                                 Puede aparecer o no
# +                                 Debe aparecer al menos 1 vez consecutiva
# *                                 Puede no apacecer o hacerlo consecutivamente todas las veces que quiera
# {4}                               Debe aparecer 4 veces consecutivas
# {2,3}                             Debe aparecer consecutivamente entre 2 y 3 veces


PATRON="^(([0-9])|([1-9][0-9]+))$"
TEXTO="33"

if [[ "$TEXTO" =~ $PATRON ]]; then
    echo "CUMPLE"
else
    echo "NO CUMPLE"
fi
