#!/bin/bash -ex

source ./variables 2> /dev/null

cd "$APP_PATH/runtime"
su $APP_USER -c ./stop.sh
