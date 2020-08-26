#!/bin/bash
# param2 bufferSize k/M/G
# param3 parallelism

URL=https://dumps.wikimedia.org/wikidatawiki/entities/latest-truthy.nt.gz

mkdir -p wikidata
cd wikidata

filename=latest-truthy.nt.gz
#download all ttl files from URL
#wget -q -O - $URL | sed 's/"/\n/g' | grep "ttl.bz2$" | sed "s|^|$URL|g" | xargs wget
wget -q -O - $URL

# Virtuoso does not recognize GeoSPARQL at 7.2.4 release 
# https://github.com/openlink/virtuoso-opensource/releases/download/v7.2.4.2/virtuoso-opensource-7.2.4.2.tar.gz
sed -i "s/#wktLiteral/#wktliteral/g" *.nt
zcat ${filename} | sed "s/#wktLiteral/#wktliteral/g" | gzip > ${filename}.clean.gz

# Optional (Remove duplicates)
gzip -dc ${filename}.clean.gz | LANG=C sort -u -S ${2} --parallel=${3} -T ~/ --compress-program=gzip | gzip > ${filename}.uniqSorted.gz