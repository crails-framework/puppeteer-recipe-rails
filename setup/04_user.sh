#!/bin/bash -ex

source ./variables 2> /dev/null

[[ -d /home/$APP_USER ]] || useradd -d /home/$APP_USER -m $APP_USER

