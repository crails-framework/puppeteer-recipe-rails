#!/bin/bash -ex

source ./variables 2> /dev/null

cd "$APP_PATH/runtime"

pid_file="$APP_PATH/runtime/tmp/pids/server.pid"

if [[ -e "$pid_file" ]] ; then
  if ps -p `cat $pid_file` ; then ;
    exit 0
  fi
fi

exit 1
