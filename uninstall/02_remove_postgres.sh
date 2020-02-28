#!/bin/bash -ex

source ./variables 2> /dev/null

echo "DROP DATABASE $INSTANCE_NAME" | su postgres -c psql
