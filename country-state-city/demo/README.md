# Countries, states, cities

```bash
bundle exec rails db:drop && bundle exec rails db:create && bundle exec rails db:migrate
bundle exec rails imports:import_v1
bundle exec rails imports:import_v2 && bundle exec rails imports:fix_sv_cities
```

```ruby
sv = Country.find_by(iso2: "SV")
sv_states = State.where(country_code: "SV").count
sv_cities = City.where(country_code: "SV").count
```
