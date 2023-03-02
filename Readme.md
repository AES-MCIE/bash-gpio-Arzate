# Introduction 
There are different ways and tools to access BeagleBone's GPIO hardware from programs, but `sysfs` is a simple one that is supported by the **Linux kernel** and makes the devices visible in the file system so we can work from the command line without needing to write any code. For simple applications you can use it with the `sysfs` way, either interactively or by putting the commands in shell scripts.

`Sysfs` is a pseudo filesystem provided by the **Linux kernel** that makes information about various kernel subsystems, hardware devices, and device drivers available in user space through virtual files. GPIO devices appear as part of sysfs.

# RaspberryPi 4 (RBPi4)

**Note: This code and commands have been tested directly on a RaspberryPi4. The GPIO process for the RBPi4 is quiete different fro, the BeagleBone Boards, please considers the instructions for RBPi4 or BBB.**

## Basic considerations

![](./rbpi4.png)

## First steps

The system has some `sysfs` GPIO drivers already loaded, you can search for them at `/sys/class/gpio/`:
```
ls /sys/class/gpio
export  gpiochip0  gpiochip504  unexport
```
We'll look at how to use this interface next. Note that the device names starting with "gpiochip" are the GPIO controllers and we won't directly use them.

Next, the basic steps to use a GPIO pin from the `sysfs` interface are:

1. Export the pin.
2. Set the pin direction (input or output).
3. If an output pin, set the level to low or high.
4. If an input pin, read the pin's level (low or high).
5. When the gpio is not used anymore, unexport the pin.

Thus, to make available the GPIO24 as an output and write a logic 1, we should do:

Export the GPIO24 by
```
echo 24 >> /sys/class/gpio/export
```
then, the `gpio24` linksys file is abilable at
```
ls /sys/class/gpio/
export  gpio24  gpiochip0  gpiochip504  unexport
```
you can go now and observe inside the `gpio24` folder a series of configuration files
```
ls /sys/class/gpio/gpio24/
active_low  device  direction  edge  power  subsystem  uevent  value
```
the ones that we require for now are the `direction` and `value`, then, to make the GPIO24 an output write a logic 1 (3V):
```
echo out >> /sys/class/gpio/gpio24/direction
echo 1 >> /sys/class/gpio/gpio24/value
```

# BeagleBone Black

## Basic considerations

![](./bbb.png)


# Manejo de los GPIOs de la BeagleBone Black
  
Este proyecto es un script que permite configurar los GPIOs de la BeagleBone. El script se ejecuta con el comando `./gpio.sh` y recibe 2 o 3 argumentos dependiendo el modo que se desee implementar.
**Nota: Para ejecutar el script se deben tener permisos de ejecucion, para agregar permisos de ejecucion se utiliza el comando:**
```
sudo chmod +x gpio.sh
```
**Teniendo en cuenta que se encuentra en la ruta del archivo.**

El primer argumento indica el numero del GPIO que se va a usar, los GPIOs permitidos son los siguientes:
```
2, 3, 4, 5, 7, 8, 9, 10, 11, 12, 13, 14, 15, 20, 22, 23, 26, 27, 30,31, 32, 33, 34, 35, 36,
37, 38,39, 44, 45, 46, 47, 48, 49, 50, 51, 60, 61, 62, 63, 65, 66, 67, 68, 69, 70, 71, 72,
73, 74, 75, 76, 77, 78, 79, 80, 81, 86, 87, 88, 89, 110, 111, 112, 113, 114, 115, 116 y 117. 
```

El segundo argumento configura el GPIO como entrada o salida recibiendo `in` y `out`. 
**Nota: En caso de configurar el GPIO como entrada ya no es necesario un tercer argumento, si se ingresa el tercer argumento este sera ignorado.** 

Configuracion del GPIO 60 como entrada.
```
./gpio.sh 60 in
```

En la configuracion del GPIO como salida el tercer argumento asigna el estado alto o bajo con `1` y `0`.

Configuracion del GPIO 60 como salida en estado alto.
```
./gpio.sh 60 out 1
```
Por ultimo, para acceder al menu de ayuda se utiliza como primer argumento un numero correspondiente a cualquier GPIO permitido y el segundo argumento es la palabra `help`.
```
./gpio.sh 2 help
```
Al igual que en la configuracion de un GPIO como entrada no es necesario un tercer argumento.
