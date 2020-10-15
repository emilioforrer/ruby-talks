# encoding: UTF-8

namespace :imports do
  desc "import countries, states, cities V2"
  task :import_all => :environment do |t, args|
    puts " == Importing countries, states and cities =="
    countries_contents = URI.open("https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/master/countries.json").read
    states_contents = URI.open("https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/master/states.json").read
    cities_contents = URI.open("https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/master/cities.json").read
    data = HashWithIndifferentAccess.new({
      "countries": JSON.parse(countries_contents),
      "states": JSON.parse(states_contents),
      "cities": JSON.parse(cities_contents)
    })
    if Country.unscoped.count == 0 && State.unscoped.count == 0 && City.unscoped.count == 0
      Country.insert_all!(data["countries"])
      State.insert_all!(data["states"])
      City.insert_all!(data["cities"])
      puts "  == countries, states and cities imported =="
    else
      puts "  == Alredy imported =="
    end
  end

  desc "Fix SV cities"
  task :fix_sv_cities => :environment do |t, args|
    puts " == Fix SV cities =="
    file = "#{Rails.root.to_s}/db/imports/cities-sv-left.json"
    contents = File.read(file)
    data = JSON.parse(contents)
    last_seq = City.all.pluck(:id).max()
    ApplicationRecord.connection.execute("ALTER SEQUENCE cities_id_seq RESTART WITH #{last_seq + 1}")
    data.each do |c|
      search_params = {
        country_code: c["country_code"],
        state_code: c["state_code"],
        name: c["name"]
      }
      city = City.where(search_params).first || City.new(search_params)
      city.country_id = Country.where(iso2: c["country_code"]).first&.id
      city.state_id = State.where(country_code: c["country_code"], state_code: c["state_code"]).first&.id
      city.latitude = c["latitude"]
      city.longitude = c["longitude"]
      city.save      
    end
    City.where(country_code: "SV", state_code: "CU", name: "San Martín").first.try(:destroy)
    City.where(country_code: "SV", state_code: "CU", name: "Tecoluca").first.try(:destroy)
    City.where(country_code: "SV", state_code: "MO", name: "San Francisco").update_all(name: "San Francisco Gotera")
    puts "  == cities imported =="
  end
end

