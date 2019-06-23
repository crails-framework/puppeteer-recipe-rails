#!/bin/bash -ex

source ./variables 2> /dev/null

apt-get update

apt-get install -y software-properties-common

add-apt-repository universe
apt-get update

apt-get install -y \
  build-essential \
  libxml2 \
  libxslt1.1 \
  rsync \
  nodejs \
  ruby \

gem install bundler
