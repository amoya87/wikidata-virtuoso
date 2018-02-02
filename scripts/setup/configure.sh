#virtuoso.ini
# parar el servicio por pid
 kill `pidof virtuoso-t`
 
# preguntar al usuario la memoria disponible para virtuoso ofreciendo sugerencias basadas en la memoria disponible
# editar el fichero virtuoso.ini
# NumberOfBuffers
# MaxDirtyBuffers
system_memory_in_mb=`free -m | awk '/:/ {print $2;exit}'`
numberOfBuffers=$(($system_memory_in_mb * 83.0078125))
MaxDirtyBuffers=$(($system_memory_in_mb * 63.4765625))


# preguntar al usuario el directorio de datos, por defecto el $home
# editar el fichero virtuoso.ini
# DirsAllowed  = ..., /path/to/data

# riniciar el servicio virtuoso
virtuoso-t &