#!/bin/bash -ex

source ./variables 2> /dev/null

userdel -f $APP_USER
rm -Rf $APP_PATH
