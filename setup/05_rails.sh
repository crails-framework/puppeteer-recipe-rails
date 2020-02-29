#!/bin/bash -ex

source ./variables 2> /dev/null

mkdir -p "$APP_PATH"
mkdir -p "$APP_PATH/runtime"

bash rails.env   > "$APP_PATH/env.puppet"
cp rails.launch "$APP_PATH/runtime/launch.sh"
cp rails.stop   "$APP_PATH/runtime/stop.sh"

if [ ! -f "$APP_PATH/env" ] ; then
  bash default.env > "$APP_PATH/env"
fi

chmod +x "$APP_PATH/runtime/"{launch,stop}.sh
