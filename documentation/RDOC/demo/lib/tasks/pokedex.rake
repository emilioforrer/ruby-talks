namespace :pokedex do
  desc 'Import of zip codes table'
  task import_pokemons: :environment do
    ImportPokemonsJob.perform_now(Rails.root.join('db/imports/pokemons.csv').to_s)
  end

  task seed_pokedex: :environment do
    abort('ERROR -> Pokemons must be imported!') if Pokemon.count.zero?
    SeedPokedexJob.perform_now
  end
end
