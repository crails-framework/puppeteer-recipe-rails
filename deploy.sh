#!/bin/bash -ex

source ./variables 2> /dev/null

cd "$APP_PATH"/runtime

echo "- removing old sprockets-manifest file"
rm public/assets/.sprockets-manifest-*.json || echo "-- no older sprockets-manifest file found"

echo "- extracting build"
tar -xf "$BUILD_TARBALL"
chown -R "$APP_USER":"$APP_USER" "$APP_PATH"/runtime

echo "- matching bundler version with the build's"
gem install bundler -v "$(grep -A 1 "BUNDLED WITH" Gemfile.lock | tail -n 1)"

echo "- updating application"
su "$APP_USER" -c ". ../env && bundle install --path vendor/bundle"

if [[ "$RAILS_SKIP_MIGRATE" != "1" ]] ; then
  su "$APP_USER" -c ". ../env && bundle exec rake db:migrate"
fi

if [[ "$RAILS_SEED_ON_DEPLOY" == "1" ]] ; then
  su "$APP_USER" -c ". ../env && bundle exec rake db:seed"
fi
