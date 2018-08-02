#!/bin/bash
# Takes as argument a VOS sql file and executes it
# e.g. $sh virtuoso-run-script.sh enable-auto-indexing.sql
# <virtuoso isql path>  <isql port> <user> <port>
query=`cat $1`
encoded_query=$(python -c "import urllib; print urllib.quote_plus('''$query''')")
cad="set blobs on; SPARQL $encoded_query ;"
isql-v 1111 dba dba VERBOSE=OFF EXEC="$cad" > ${1}_resp.txt
