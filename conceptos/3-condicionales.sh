#!/bin/bash

## Condicionales
# 
#   if CONDICION
#   then
#       # CODIGO A EJECUTAR SI SE CUMPLE LA CONDICION
#   elif CONDICION2; then
#       # CODIGO A EJECUTAR SI SE CUMPLE LA CONDICION2
#   else
#       # CODIGO A EJECUTAR SI NO SE CUMPLEN LA CONDICION ni CONDICION2
#   fi

## CONDICIONES:
### En sh, las condiciones se definen dentro de [  ]. Podemos poner muy poca variedad de condiciones.
### A utilizar dentro de los caracteres [[  ]]. <<< SINTAXIS ESPECIAL BASH

#### Textos
    #  ==      Compara dos textos a ver si son iguales        **** IMPORTANTE
    #  !=      Compara dos textos a ver si son diferentes     **** IMPORTANTE
    #  >       Compara dos textos a ver si uno va antes que el otro (orden ascii)  a < b VERDADERO
                                                                                # 10 < 9 VERDADERO
    #  <       
    #  >=      
    #  <=      
    #  -z "$VAR"     Compara si una variable ESTA VACIA.      **** IMPORTANTE
    #  -n "$VAR"     Compara si una variable NO ESTA VACIA    **** IMPORTANTE
    #  -v "$VAR"     Compara si una variable ESTA ASIGNADA, si TIENE VALOR, aunque sea ""
    #  =~       Comprueba si un texto cumple o no con una expresión regular.

#MI_VARIABLE=HOLA AMIGO

    # if [[ -z $MI_VARIABLE ]]; then  ->   if [[ -z HOLA AMIGO ]]; then
                                            # Esto es lo que se ejecuta tras sustituir valores
                                            # Error de sintaxis: AMIGO orden no encontrada
    # if [[ -z "$MI_VARIABLE" ]]; then  ->   if [[ -z "HOLA AMIGO" ]]; then
                                            # Esto es lo que se ejecuta tras sustituir valores
                                            # Perfecto. FALSE. NO ESTA VACIA
    # if [[ -z '$MI_VARIABLE' ]]; then  ->   if [[ -z '$MI_VARIABLE' ]]; then
                                            # Esto es lo que se ejecuta tras sustituir valores
                                            # ERROR. Funciona, pero no es lo que queremos. Siempre FALSE

if [[ -z '$MI_VARIABLE' ]]; then
    echo "ESTA VACIA"
else
    echo "NO ESTA VACIA"
fi

#### Operadores específicos para ficheros. Los veremos mas tarde
#### Numeros.  ESTA SINTAXIS NO SE USA... ES MUY INCOMODA
    # [[ ]]                       (( ))
    # -eq       Equals.            ==
    # -ne       NotEquals.         !=
    # -gt       GreaterThan.       >
    # -lt       Lower Than         <
    # -le       Lower or Equals.   <=
    # -ge       Greater or Equals. >=
numero1=10
numero2="10.0"
if [[ "${numero1}" == "${numero2}" ]]; then
    echo "Son textos iguales"
elif [[ "${numero1}" -eq "${numero2}" ]]; then
    echo "Son numeros iguales"
else
    echo "Son distintos"
fi

### A utilizar dentro de los caracteres ((  )). <<< SINTAXIS ESPECIAL BASH
# En este caso, la bash interpreta la condición como expresiones matemáticas
    # ==
    # !=
    # >
    # >=
    # <
    # <=
    
if [[ "10" < "9" ]]; then # Comparando ordenes ascii
    echo "10 va antes en orden de caracteres que 9"
else
    echo "Diez mayor que nueve"
fi
if (( "10" < "9" + 2 )); then # En una expresión matematica podemos poner + - * /. Estas igual las usamos en el let
    echo "Diez menor que once"
else
    echo "Diez mayor que once"
fi

#################################################
#######.   CASE 
#################################################
color="oscuro"
case "$color" in
    azul)
        echo AZUL
    ;;
    verde)
        echo VERDE
    ;;
    rojo)
        echo ROJO
    ;;
    negr*|oscuro)
        echo NEGRO
    ;;
    *)  # Aqui usamos un caracter comodin... cualquier cosa... Otro valor
        echo OTRO
    ;;
esac

### Andición de condiciones. Operadores lógicos
# !           not.          true -> false.        false -> true
if [[ ! -n "$VARIABLE_QUE_NO_EXISTE" ]]; then
    echo "HOLA !"
fi
## condicion1 && condicion2     and logico
## condicion1 || condicion2     or logico
sudo apt update && sudo apt install git -y
    # Si el update acaba bien, hace el install. Por qué?

# En el caso de arriba, que es lo que entra como condicion1?: sudo apt update???
# La salida estandar del sudo apt update? NO, NI DE COÑA... ahi tendremos otra sintaxis.. que luego cuento.
# El código de salida del proceso: EXIT_CODE

# En un SO (windows, LINUX, UNIX) cuando un proceso termina su ejecución devuelve un CODIGO DE SALIDA:
#   0 - Si acaba correcto
#   Cualquier otro valor - Si acaba incorrecto
#                           Cada programa define el significado de los exit-code incorrectos
# En la shell (SH-POSIX) 0 -> TRUE
#                        Cualquier valor que no es un 0 se interpreta como false
sudo yum update || sudo apt update

# Tanto el && como el || funcionan en cortocircuito. Esto es:
    # cond1 && cond2        cond2 solo se ejecuta si se cumple la primera condicion
    #                       Si no, como la expresión ya va a dar false... para que ejecutar la segunda
    # cond1 || cond2        cond2 solo se ejecuta si no se cumple la primera condicion
    #                       Si no, es decir, si cond1 ya se ha cumplido, da igual lo que valiera la segunda condicion
    #                       El resultado de la expresion siempre será true... y por eso ya no se evalua la segunda

# Como capturo el código de salida de un programa? $?  Codigo del ultimo programa en ejecutarse

# Uso de estos operadores para montar if en linea

VAR_QUE_NO_EXISTE="SI QUE EXISTO"
[[ -z "$VAR_QUE_NO_EXISTE" ]] && echo "La variable no existe" || echo "La variable si existe"

if [[ -z "$VAR_QUE_NO_EXISTE" ]]; then
    echo "La variable no existe" 
else 
    echo "La variable si existe"
fi