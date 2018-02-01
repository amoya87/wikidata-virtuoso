URL=https://dumps.wikimedia.org/wikidatawiki/entities/latest-truthy.nt.bz2

mkdir -p wikidata
cd wikidata

# set the default graph
echo "http://wikidata.org" >  ./global.graph

#download all ttl files from URL
#wget -q -O - $URL | sed 's/"/\n/g' | grep "ttl.bz2$" | sed "s|^|$URL|g" | xargs wget
wget -q -O - $URL

# virtuoso does not handle bz2 compressions
bunzip2 *.bz2

# Virtuoso does not recognize GeoSPARQL at 7.2.4 release 
# https://github.com/openlink/virtuoso-opensource/releases/download/v7.2.4.2/virtuoso-opensource-7.2.4.2.tar.gz
sed 's/#wktLiteral/#wktliteral/g' *.nt

# recompress to save space, gz is fine for loading
gzip *.nt
