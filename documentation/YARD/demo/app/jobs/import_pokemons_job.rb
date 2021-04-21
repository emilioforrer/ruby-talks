class ImportPokemonsJob < ApplicationJob
  queue_as :default
  # @attr_reader [Array] pokemons represents the total of pokemons
  attr_reader :pokemons

  # Initialize import pokemons job
  # @param path [String, #read] path of the csv file
  def perform(path)
    @pokemons = []
    create_pokemons!(path)
  end

  private

  def create_pokemons!(path)
    require 'csv'

    records = CSV.parse(File.read(path), headers: true)
    records.each do |record|
      construct_model(record)
    end
    import = Pokemon.insert_all(pokemons, returning: %w[id])
    print_result!(import, records.length)
  end

  # @note This method should only be used to build the model
  # @param record [Hash, #read] row of the csv file
  def construct_model(record)
    type_id = record['Type'].present? ? Type.find_or_create_by(name: record['Type'])&.id : nil
    image_name = record['Name'].parameterize.gsub('-', '_')
    pokemons << { total: record['Total'], type_id: type_id, name: record['Name'],
                  hp: record['HP'], attack: record['Attack'], defense: record['Defense'],
                  speed: record['Speed'], generation: record['Generation'], legendary: record['Legendary'] == 'True',
                  image_url: "https://play.pokemonshowdown.com/sprites/gen#{record['Generation']}/#{image_name}.png" }
  end

  def print_result!(import, total)
    success = import.rows.length
    failed =  total - success
    puts '******************************************'
    puts "#{success} records of #{total} inserted sucessfully"
    puts "#{failed} records of #{total} were not inserted"
  end
end
