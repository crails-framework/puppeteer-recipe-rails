#!/bin/bash -x

source ./variables 2> /dev/null
cd "$APP_PATH/runtime"
source ../env 2> /dev/null

logfile="$APP_PATH/runtime/log/$RAILS_ENV.log"

wc -l "$logfile" | cut -d' ' -f1
tail -n 500 "$logfile"
