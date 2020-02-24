#!/bin/bash -ex

source $1 2> /dev/null

cd "$APP_PATH"/runtime
tar -xf "$BUILD_TARBALL"

./stop.sh
./launch.sh
