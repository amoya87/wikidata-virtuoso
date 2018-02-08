wget https://github.com/openlink/virtuoso-opensource/releases/download/v7.2.4.2/virtuoso-opensource-7.2.4.2.tar.gz
sudo aptitude install dpkg-dev build-essential
sudo apt-get install autoconf automake libtool flex bison gperf gawk m4 make odbcinst libxml2-dev libssl-dev libreadline-dev
tar xvpfz virtuoso-opensource-7.2.4.2.tar.gz
cd virtuoso-opensource-7.2.4.2/
./autogen.sh
./configure --prefix=/usr/local/ --with-readline --program-transform-name="s/isql/isql-v/"
nice make
sudo make install
cd /usr/local/var/lib/virtuoso/db/
sudo chown -R $(whoami) .
virtuoso-t &
