#! /bin/bash

echo "Ejecutando"
Num=$1
gpio=/sys/class/gpio/gpio
 
function gpioIn
{
        echo in >> $gpio$Num/direction
}

function gpioOut
{
    echo out >> $gpio$Num/direction
}

function gpioValue
{
    cat $gpio$Num/value
}
 
function Error
{
    echo "Error, intente ./gpio-bash 2 help para mas informacion"
}
 
if [ -d "$gpio$Num" ]; then
    echo "Gpio correcto"
else
    Error
    exit 2
fi
 
if [[ $# != 2 && $# != 3 ]]; then
    echo "Error en el numero de argumentos"
    Error
    exit 0
 
fi
 
if [[ $# == 2 || $# == 3 ]]; then
    if [ $2 == "in" ]; then
        gpioIn
        gpioValue
        echo "Ok"
        exit 0
 
     elif [ $2 == "out" ]; then
        gpioOut
        if [[ $3 == 0 || $3 == 1 ]]; then
             echo $3 >> $gpio$Num/value
             echo "Ok"
        else
             Error
             exit 0
        fi
     elif [ $2 == "help" ]; then
        echo "***************************************************************************************************************************************"
        echo "El scrip recibe de 2 a 3 argumentos de entrada, el primer argumento indica el gpio al que se le modificara su estado"
        echo "El segundo argumento lo configura como entrada o salida"
        echo "En caso de configurarse como salida se tiene un tercer argumento indicando la misma."
        echo ""
        echo "Los gpio que se pueden usar son los siguientes: 2, 3, 4, 5, 7, 8, 9, 10, 11, 12, 13, 14, 15, 20, 22, 23, 26, 27, 30,"
        echo "31, 32, 33, 34, 35, 36, 37, 38, 39, 44, 45, 46, 47, 48, 49, 50, 51, 60, 61, 62, 63, 65, 66, 67, 68, 69, 70, 71, 72," 
        echo "73, 74, 75, 76, 77, 78, 79, 80, 81, 86, 87, 88, 89, 110, 111, 112, 113, 114, 115, 116 y 117."
        echo ""
        echo "Para configurar el gpio como entrada se utiliza el comando con la palabra in."
        echo "./gpio-bash.sh 60 in      --Se configura como entrada el gpio60"
        echo "./gpio-bash.sh 60 in 1    --En este caso se ignora el tercer argumento"
        echo "Para configurar como salida se utiliza el comando con la palabra out. Ejemplos:"
        echo "./gpio-bash.sh 60 out 1"
        echo "El tercer argumento puede ser un 0 o 1 dependiendo lo que se desee realizar"
        echo ""
        echo "Para acceder a este instructivo se usa como primer argumento cualquier cualquier gpio valido y la palabra help en el segundo argumento"
        echo "***************************************************************************************************************************************"
    else
        Error
        exit 0
    fi
fi
