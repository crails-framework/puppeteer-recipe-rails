#!/bin/bash -ex

source ./variables 2> /dev/null

apt-get install -y monit

systemctl enable monit

bash monit.config > /etc/monit/conf.d/settings
