# Countries, states, cities

## Copy the files

Copy the files from the resources folder to the root of the project

## Run tasks

```bash
bundle exec rails db:drop && bundle exec rails db:create && bundle exec rails db:migrate

bundle exec rails imports:import_all && bundle exec rails imports:fix_sv_cities
```