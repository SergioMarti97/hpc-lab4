#!/bin/bash

# Cortar y reducir ficheros

USER_NAME=$(whoami)

USER_NUM=$(echo $USER_NAME | cut -c7-)

echo "Usuario: $USER_NAME"
echo "Número usuario: $USER_NUM"


# Recorro todos los archivos que se llamen "Sample" y algo más...
for FILE_NAME in $(echo Sample*); do

	###################################################################
        # Quedarme solamente con las lineas multiplo de mi número de alumno
        ###################################################################

	# Creo un archivo a partir del nombre original, pero en medio tendrá: "_reduced"
	OUTPUT_FILE_NAME="$(echo $FILE_NAME | cut -d'.' -f1)_reduced.$(echo $FILE_NAME | cut -d'.' -f2)"

	echo "Nombre del fichero: $FILE_NAME"
	echo "Nombre del fichero de salida: $OUTPUT_FILE_NAME"

        # Necesito un contador para saber si la linea es multiplo o no de mi número de alumno
        # Comienza en 0
        COUNT=0

        # Voy a crear otro contador, para guardar el número de lineas que se guardan
        COUNT2=0

        # Leo las líneas del fichero de salida de la primera parte
        # Se podría hacer mejor si no se crease un archivo de por medio, pero no lo se hacer así
        while read LINE; do

                # Si el número de la línea es multiplo del número del alumno...
                if [[ $((($COUNT % $USER_NUM))) -eq 0 ]]; then
                        # Imprimo por salida estandar la linea
                        echo "$LINE"
                        COUNT2=$((($COUNT2 + 1)))
                fi

                # Incremento el contador
                COUNT=$((($COUNT + 1)))

        # La salida estandar se redirige al fichero "_reduced"
        done < $FILE_NAME > $OUTPUT_FILE_NAME

        echo "Número de líneas del fichero reducido: $COUNT2"

	# El ejercicio dice que se sobrescriba los fichero de entrada
	# con los ficheros de salida: se borra el original y se remplaza por
	# la salida
	rm $FILE_NAME
	mv $OUTPUT_FILE_NAME $FILE_NAME

	echo "Se ha borrado el archivo de entrada: $FILE_NAME"
	echo "Se ha cambiado el nombre del archivo de salida: $OUTPUT_FILE_NAME > $FILE_NAME"

done
