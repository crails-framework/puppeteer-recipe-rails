#!/bin/bash -ex

source ./variables 2> /dev/null

cat rails.backup  > "$APP_PATH/backup.sh"
cat rails.restore > "$APP_PATH/restore.sh"
