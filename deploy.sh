#!/bin/bash -ex

source ./variables 2> /dev/null

cd "$APP_PATH"/runtime
echo "- removing old sprockets-manifest file"
rm public/assets/.sprockets-manifest-*.json || echo "-- no older sprockets-manifest file found"
tar -xf "$BUILD_TARBALL"

chown -R "$APP_USER":"$APP_USER" "$APP_PATH"/runtime

su "$APP_USER" -c ". ../env && bundle install --path vendor/bundle"
su "$APP_USER" -c ". ../env && bundle exec rake db:migrate"
