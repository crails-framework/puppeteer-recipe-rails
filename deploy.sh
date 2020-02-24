#!/bin/bash -ex

source ./variables 2> /dev/null

cd "$APP_PATH"/runtime
tar -xf "$BUILD_TARBALL"

chown -R "$APP_USER":"$APP_USER" "$APP_PATH"/runtime

su "$APP_USER" -c "bundle exec rake db:migrate"
