class SeedPokedexJob < ApplicationJob
  queue_as :default

  # @!attribute [r] pokemons
  #   @return [Fixnum] represents the total of pokemons
  attr_reader :pokemons

  # @!attribute [r] pokedex_limit
  #   @return [Fixnum] the size of the list represents the total of pokemons allowed per user
  attr_reader :pokedex_limit

  def perform
    @pokemons = Pokemon.all
    users_amount = ENV.fetch('USER_TO_CREATE', '10').to_i
    @pokedex_limit = ENV.fetch('POKEDEX_LIMIT', '5').to_i
    users_amount.times do
      create_user!
    end
  end

  private

  def create_user!
    user = User.create(first_name: ::Faker::Name.first_name, last_name: ::Faker::Name.last_name,
                       email: ::Faker::Internet.unique.safe_email, password: '123456!')

    attach_pokemons!(user)
  end

  def attach_pokemons!(user)
    pokemons_ids = pokemons.sample(pokedex_limit).pluck(:id)
    user.pokemon_ids = pokemons_ids
  end
end
