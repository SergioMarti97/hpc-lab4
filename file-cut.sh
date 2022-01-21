#!/bin/bash

# Cortar y reducir ficheros

USER_NAME=$(whoami)

USER_NUM=$(echo $USER_NAME | cut -c7-)

echo "Usuario: $USER_NAME"
echo "Número usuario: $USER_NUM"


# Recorro todos los archivos que se llamen "Sample" y algo más...
for FILE_NAME in $(echo Sample*); do

	################################################
	# Quedarme con la parte proporcional del archivo
	################################################

	# Creo un archivo a partir del nombre original, pero en medio tendrá: "_cutted"
	OUTPUT_FILE_NAME="$(echo $FILE_NAME | cut -d'.' -f1)_cutted.$(echo $FILE_NAME | cut -d'.' -f2)"

	# Número de lineas del archivo
	NUM_FILE_LINES=$(wc -l < $FILE_NAME)

	# Número de lineas con las que me debo de quedar
	NUM_LINES_TO_CUT=$((($NUM_FILE_LINES / $USER_NUM)))

	echo "Nombre del fichero: $FILE_NAME"
	echo "Nombre del fichero de salida: $OUTPUT_FILE_NAME"
	echo "Número de líneas del fichero: $NUM_FILE_LINES"
	echo "Número de líneas para cortar: $NUM_LINES_TO_CUT"

	# Corto el archivo con el comando head
	head -n$NUM_LINES_TO_CUT $FILE_NAME > $OUTPUT_FILE_NAME

	# El ejercicio dice que se sobrescriba los fichero de entrada
	# con los ficheros de salida: se borra el original y se remplaza por
	# la salida
	rm $FILE_NAME
	mv $OUTPUT_FILE_NAME $FILE_NAME

	echo "Se ha borrado el archivo de entrada: $FILE_NAME"
	echo "Se ha cambiado el nombre del archivo de salida: $OUTPUT_FILE_NAME > $FILE_NAME"

done
