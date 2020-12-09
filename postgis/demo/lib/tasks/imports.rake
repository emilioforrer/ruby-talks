# encoding: UTF-8

namespace :imports do
  desc "import geodata"
  task :import_geodata => :environment do |t, args|
    puts " == Importing geodata"
    file = "#{Rails.root.to_s}/db/imports/san-benito-plaza.json"
    contents = File.read(file)
    geo_json = JSON.parse(contents, symbolize_names: true)
    location = Location.where(name: "Plaza San Benito").first_or_initialize
    factory = Factories::Geo
    geo_json[:features].each do |feature|
      type = feature[:properties].fetch(:type)
      geomerty = feature[:geometry]
      case type
      when "place"
        if geomerty[:type] == "Polygon"
          points = factory.pairs_to_points(geomerty.fetch(:coordinates).first)
          location.area = factory.polygon(points)
        end
        if geomerty[:type] == "Point"
          points = geomerty.fetch(:coordinates)
          location.coords = factory.point(*points)
        end
      when "user"
        properties = feature[:properties]
        user = User.where(name: properties[:name]).first_or_initialize
        user.description = properties[:description]
        points = geomerty.fetch(:coordinates)
        user.coords = factory.point(*points)
        user.save
        puts "#{feature.inspect} #{user.inspect}"
      end
    end
    location.save
    puts "  == geodata imported =="
  end

  desc "import countries, states, cities V2"
  task :import_all => :environment do |t, args|
    puts " == Importing countries, states and cities =="
    base_uri = "https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/v0.9"
    countries_contents = URI.open("#{base_uri}/countries.json").read
    states_contents = URI.open("#{base_uri}/states.json").read
    cities_contents = URI.open("#{base_uri}/cities.json").read
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
      puts "  == Already imported =="
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

