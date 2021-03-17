#!/bin/bash -ex

source ./variables 2> /dev/null

chmod +x get_psql_version

psql_database_path="/var/lib/postgresql/data"
psql_pid_path="$psql_database_path/postmaster.pid"
psql_service="/usr/lib/postgresql/$psql_version/bin/pg_ctl -D $psql_database_path -l /var/lib/postgresql/log"

apt-get install -y postgresql

psql_version=`./get_psql_version`

if [[ -z "$APP_SQL_DATABASE" ]] ; then
  export APP_SQL_DATABASE="$INSTANCE_NAME"
fi

if [[ -z "$APP_SQL_USER" ]] ; then
  export APP_SQL_USER="$APP_USER"
fi

#
# initialize database
#
mkdir -p "$psql_database_path"
chown postgres "$psql_database_path"

if [[ -e "$psql_database_path"/pg_hba.conf ]] ; then
  echo "(!) psql database already exists"
else
  su postgres -c "/usr/lib/postgresql/$psql_version/bin/initdb --locale=C.UTF-8 -D \"$psql_database_path\""
fi

cp pg_hba.conf "$psql_database_path"/pg_hba.conf

pg_isready || su postgres -c "$psql_service start"

#
# configure psql users
#
user_exists=`psql -U postgres -tAc "SELECT 1 FROM pg_roles WHERE rolname='$APP_SQL_USER'" | grep 1 || echo "0"`

if [[ $user_exists == 1 ]] ; then
  echo "ALTER USER $APP_SQL_USER WITH PASSWORD '$APP_SQL_PASSWORD';" | su postgres -c psql
else
  echo "CREATE USER $APP_SQL_USER WITH PASSWORD '$APP_SQL_PASSWORD';" | su postgres -c psql
fi

echo "ALTER USER postgres WITH PASSWORD '$APP_SQL_PASSWORD';" | su postgres -c psql

echo 'CREATE DATABASE "'"$APP_SQL_DATABASE"'"' | su postgres -c psql
echo 'GRANT ALL PRIVILEGES ON DATABASE "'"$APP_SQL_DATABASE"'" TO "'"$APP_SQL_USER"'"' | su postgres -c psql
