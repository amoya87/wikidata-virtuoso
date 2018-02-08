#!/bin/bash
#virtuoso.ini
# stop service by pid
kill -9 `pidof virtuoso-t`

system_memory_in_mb=`free -m | awk '/:/ {print $2;exit}'`
echo La memoria libre es: $system_memory_in_mb
# each buffer caches a 8K page of data and occupies approx. 8700 bytes of memory
# it's suggested to set this value to 65 % of ram for a db only server
# so if you have 32 GB of ram: 32*1000^3*0.65/8700 = 2390804
# default is 2000 which will use 16 MB ram ;)
numberOfBuffers=$(($system_memory_in_mb * 80))
read -p "Enter the number of buffers [$numberOfBuffers]: " numberOfBuffers;
if [[ ( $numberOfBuffers = "") ]] ;then
	numberOfBuffers=$(($system_memory_in_mb * 80));
fi;
echo NumberOfBuffers = $numberOfBuffers

maxDirtyBuffers=$(($numberOfBuffers * 3/4))
echo MaxDirtyBuffers = $maxDirtyBuffers

# set this to 1/4th of NumberOfBuffers
maxCheckpointRemap=$(($numberOfBuffers * 1/4))
echo MaxCheckpointRemap = $maxCheckpointRemap

sed -i "s/^NumberOfBuffers.*/NumberOfBuffers          = ${numberOfBuffers}/g" /usr/local/var/lib/virtuoso/db/virtuoso.ini
sed -i "s/^MaxDirtyBuffers.*/MaxDirtyBuffers          = ${maxDirtyBuffers}/g" /usr/local/var/lib/virtuoso/db/virtuoso.ini
sed -i "s/^MaxCheckpointRemap.*/MaxCheckpointRemap              = ${maxCheckpointRemap}/g" /usr/local/var/lib/virtuoso/db/virtuoso.ini

# ask for path of input data
read -p "Enter the path to dir of input data [/path/to/data]: " DIR;
echo DirsAllowed += $DIR


# DirsAllowed  = ..., /path/to/data
if [[ -d $DIR ]] ; then 
	sed -i "/^DirsAllowed.*/s|$|, ${DIR}|g" /usr/local/var/lib/virtuoso/db/virtuoso.ini
fi;

# start virtuoso service
virtuoso-t +configfile /usr/local/var/lib/virtuoso/db/virtuoso.ini &
