

```ruby
bundle add activerecord-postgis-adapter

bundle exec rails db:gis:setup
```

## Postgres

Check available extensions

```
select * from pg_available_extensions where name like '%postgis%';
```

Check enabled extensions

```
select * from pg_extension
```

## Import

```
docker-compose exec web bash
bundle exec rails imports:import_geodata 
```

## Console

```
docker-compose exec web bash
bundle exec rails c

Location.within(User.john.coords, 100)
Location.within(User.jane.coords, 100)
Location.within(User.barry.coords, 100)
User.within_polygon(Location.plaza_san_benito.area)
Location.plaza_san_benito.distance_from(User.john.coords)
```