#!/bin/bash

bundle check

if [[ $RAILS_ENV == "production" || $RAILS_ENV == "staging" ]]; then
  bundle install --jobs=4 --without development test
else
  bundle install --jobs=4
fi

bundle exec rails db:create
bundle exec rails db:migrate
bundle exec puma -C config/puma.rb

exec "$@"