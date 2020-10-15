# encoding: UTF-8

namespace :imports do
  desc "import countries, states, cities v1"
  task :import_v1 => :environment do |t, args|
    puts " == Importing countries, states and cities =="
    file = "#{Rails.root.to_s}/lib/seeds/v1/countries.json"
    contents = File.read(file)
    data = JSON.parse(contents)
    if V1::Country.unscoped.count == 0 && V1::State.unscoped.count == 0 && V1::City.unscoped.count == 0
      if data["countries"].size > 0
        V1::Country.transaction do
          data["countries"].each do |c|
            states = []
            states_json = c["states"]
            c = c.except("states")
            country = V1::Country.new(c)
            if states_json.size > 0
              V1::State.transaction(requires_new: true) do
                states_json.each do |s|
                  cities = []
                  cities_json = s["cities"]
                  s = s.except("cities")
                  state = V1::State.new(s)
                  if cities_json.size > 0
                    V1::City.transaction(requires_new: true) do
                      cities_json.each do |ci|
                        cities << V1::City.new(ci)
                      end
                    end #end transaction cities
                  end
                  state.cities = cities
                  states << state
                end
              end #end transaction states
            end
            country.states = states
            country.save

          end #end countries each
        end # end transaction countries
      end
      puts "  == countries, states and cities imported =="
    else
      puts "  == Alredy imported =="
    end
  end

  desc "import countries, states, cities V2"
  task :import_v2 => :environment do |t, args|
    puts " == Importing countries, states and cities =="
    countries_contents = URI.open("https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/master/countries.json").read
    states_contents = URI.open("https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/master/states.json").read
    cities_contents = URI.open("https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/master/cities.json").read
    data = HashWithIndifferentAccess.new({
      "countries": JSON.parse(countries_contents),
      "states": JSON.parse(states_contents),
      "cities": JSON.parse(cities_contents)
    })
    if V2::Country.unscoped.count == 0 && V2::State.unscoped.count == 0 && V2::City.unscoped.count == 0
      V2::Country.insert_all!(data["countries"])
      V2::State.insert_all!(data["states"])
      V2::City.insert_all!(data["cities"])
      puts "  == countries, states and cities imported =="
    else
      puts "  == Alredy imported =="
    end
  end

  desc "Fix SV cities"
  task :fix_sv_cities => :environment do |t, args|
    puts " == Fix SV cities =="
    file = "#{Rails.root.to_s}/lib/seeds/v2/cities-sv-left.json"
    contents = File.read(file)
    data = JSON.parse(contents)
    last_seq = V2::City.all.pluck(:id).max()
    ApplicationRecord.connection.execute("ALTER SEQUENCE v2_cities_id_seq RESTART WITH #{last_seq + 1}")
    data.each do |c|
      search_params = {
        country_code: c["country_code"],
        state_code: c["state_code"],
        name: c["name"]
      }
      city = V2::City.where(search_params).first || V2::City.new(search_params)
      city.country_id = V2::Country.where(iso2: c["country_code"]).first&.id
      city.state_id = V2::State.where(country_code: c["country_code"], state_code: c["state_code"]).first&.id
      city.latitude = c["latitude"]
      city.longitude = c["longitude"]
      city.save      
    end
    V2::City.where(country_code: "SV", state_code: "CU", name: "San Martín").first.try(:destroy)
    V2::City.where(country_code: "SV", state_code: "CU", name: "Tecoluca").first.try(:destroy)
    V2::City.where(country_code: "SV", state_code: "MO", name: "San Francisco").update_all(name: "San Francisco Gotera")
    puts "  == cities imported =="
  end
end

