#!/bin/bash
ROOT="`pwd`"
if [ ! -d "${ROOT}/mariadb" ]; then
    mkdir -p "${ROOT}/mariadb"
    mysql_install_db "--datadir=${ROOT}/mariadb" "--basedir=/usr/"
fi
mysqld "--datadir=${ROOT}/mariadb" "--socket=${ROOT}/mariadb/mariadb.socket" &
mysqlPid="$!"
sleep 5
echo
for sql in *.sql;do
    echo "Importing $sql"
    sed -re 's/timestamp\([0-9]\)/timestamp/g' < "$sql" |sed -re 's/CURRENT_TIMESTAMP\([0-9]\)/CURRENT_TIMESTAMP/g' |sed -re 's/STATS_PERSISTENT=0//g' |mysql -u root "--socket=${ROOT}/mariadb/mariadb.socket" 
done
mysql -u root "--socket=${ROOT}/mariadb/mariadb.socket"
echo "Pres return to stop $mysqlPid"
read
kill "$mysqlPid"
wait

