require "test_helper"

class ImportPokemonsJobTest < ActiveJob::TestCase
  # @!method Test - Should create pokemons
  #  Use the {file:test/fixtures/files/import_pokemons_test.csv import_pokemon_test.csv} file to test the {#ImportPokemonsJob importPokemonsJob}
  
  test 'Should create Pokemons' do
    ImportPokemonsJob.perform_now(Rails.root.join('test/fixtures/files/import_pokemons_test.csv'))
    assert Pokemon.count, 9
  end
end
