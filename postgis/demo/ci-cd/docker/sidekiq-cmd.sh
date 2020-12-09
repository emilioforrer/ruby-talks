#!/bin/bash

bundle check

if [[ $RAILS_ENV == "production" || $RAILS_ENV == "staging" ]]; then
  bundle install --jobs=4 --without development test
else
  bundle install --jobs=4
fi

bundle exec sidekiq

exec "$@"