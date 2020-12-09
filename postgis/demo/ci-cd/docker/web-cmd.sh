#!/bin/bash

bundle check

if [[ $RAILS_ENV == "production" || $RAILS_ENV == "staging" ]]; then
  bundle install --jobs=4 --without development test
else
  bundle install --jobs=4
fi

echo "Checking for Postgres..."
until nc -z -v -w 30 ${DB_HOST} ${DB_PORT}; do
  echo "Postgres is unavailable - sleeping"
  sleep 1
done
echo "Postgres is available: continuing with database setup..."

bundle exec rails db:create
bundle exec rails db:migrate
bundle exec puma -C config/puma.rb

exec "$@"