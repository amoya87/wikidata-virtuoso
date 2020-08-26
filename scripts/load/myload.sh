#!/bin/bash
# param1 source sorted folder
# param2 target index folder
# param3 target complete index folder
# param4 load scripts source folder
dbs=`ls ${1}`
hm=`pwd`
echo "dbs: $dbs"
for db in ${dbs}; do
    echo "Downloading file to index"
    cp ${1}/${db} ${hm}
    dbi=$(echo $db | grep -o -E '[0-9]+')
    kill -9 `pidof virtuoso-t`
    cd /usr/local/var/lib/virtuoso/db/
    cp virtuoso.ini backup.virtuoso.ini ; rm virtuoso* ; mv backup.virtuoso.ini virtuoso.ini
    ln -s ${hm}/${2}/${dbi} virtuoso.db
    virtuoso-t &
    cd ${hm}/${4}
    sed -i "s/^ld_add.*/ld_add ('\/home\/albertomoya87\/${db}', 'http:\/\/wikidata.org');/g" load_data.sql
    echo "Waiting 2 minutes while the Virtuoso service start"
    sleep 120
    start=`date +%s`
	echo "Bulk loading"
    sh bulk_load.sh
    end=`date +%s`
    runtime=$((end-start))
    echo "Indexed in ${runtime} seconds"
    cd ${hm}
    mv ${2}/${dbi} ${3} &
	rm ${db}
done