#virtuoso.ini
# parar el servicio por pid
 kill `pidof <name>`
# preguntar al usuario la memoria disponible para virtuoso ofresiendo sugerencias basadas en la memoria disponible
# editar el fichero virtuoso.ini
# NumberOfBuffers
# MaxDirtyBuffers

# preguntar al usuario el directorio de datos, por defecto el $home
# editar el fichero virtuoso.ini
# DirsAllowed  = ..., /path/to/data

# riniciar el servicio virtuoso
virtuoso-t &