#!/bin/bash -ex

source $1 2> /dev/null

tar -xf "$BUILD_TARBALL"

./stop.sh
./launch.sh
