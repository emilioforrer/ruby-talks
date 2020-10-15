# Countries, states, cities

```bash
bundle exec rails db:drop && bundle exec rails db:create && bundle exec rails db:migrate
bundle exec rails imports:import_v1
bundle exec rails imports:import_v2 && bundle exec rails imports:fix_sv_cities
```

```ruby
sv = V1::Country.find_by(iso: "SV")
sv_states = V1::State.joins(:country).where("v1_countries.iso = ?", "SV").count
sv_cities = V1::City.joins(state: :country).where("v1_countries.iso = ?", "SV").count

sv = V1::Country.find_by(iso: "SV")
sv_states = V2::State.where(country_code: "SV").count
sv_cities = V2::City.where(country_code: "SV").count

```

## TODO

Make a batch import


```
states = []

sv_states = V2::State.where(country_code: "SV")
sv_states.each do |state|
  states << {
    name: state.name,
    id: state.id,
    country_id: state.country_id,
    code: state.state_code,
    cities: state.cities.map(&:name)
  }
end

V2::City.where(country_code: "SV", state_code: "CU", name: "San Martín").first.destroy
V2::City.where(country_code: "SV", state_code: "CU", name: "Tecoluca").first.destroy
V2::City.where(country_code: "SV", state_code: "MO", name: "San Francisco").first.update_all(name: "San Francisco Gotera")

# List sequences
SELECT c.relname,  FROM pg_class c WHERE (c.relkind = 'S');


```