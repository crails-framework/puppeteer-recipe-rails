#!/bin/bash -ex

source ./variables 2> /dev/null

if [[ -z "$APP_SQL_DATABASE" ]] ; then
  export APP_SQL_DATABASE="$INSTANCE_NAME"
fi

echo "DROP DATABASE $APP_SQL_DATABASE" | su postgres -c psql
