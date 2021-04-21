module Operations
  module Pokedex
    # = Operation to add pokemon to pokedex
    # == validate_pokemon!
    # Method used to validate if pokemon exist
    # === error!
    # Raised using Paw::Utils
    # == validate_pokedex_size!
    # Method used to valid if pokemon exist
    # == persist!
    # Method used to save data
    class AddPokemon < Trailblazer::Operation
      delegate :error!, to: Paw::Utils
      pass :validate_pokemon!
      pass :validate_pokedex_size!
      pass :persist!
      pass :present!

      # Method used to valid if pokemon exist
      # [find] Find pokemon by params on route
      # [error!] Raise error if pokemon is not found
      def validate_pokemon!(options, params:, **)
        options[:model] = Pokemon.find_by(id: params[:pokemon_id])
        error!(status: 404, message: I18n.t('paw.api.messages.not_found')) if options[:model].nil?
      end

      ##
      # Method used to validate if the limit of the pokedex has been reached <br>
      #--
      # This is a internal comment
      #++
      # 1. raise ::Paw::Exceptions::StandardError if the User reach the maximum of pokemons allowed
      # 2. raise ::Paw::Exceptions::StandardError if the User reach the maximum of pokemons allowed
      def validate_pokedex_size!(options, current_user:, **)
        options[:pokedex] = current_user.pokemon_ids
        error!(status: 403, message: 'User reached the maximum of pokemons allowed') if options[:pokedex].size >= 5
      end

      # Method used to save data
      def persist!(options, current_user:, **)
        ::Pokedex.create(user_id: current_user.id, pokemon_id: options[:model].id)
      end

      # Method used to retrieve information to user
      # * First create de data
      # * Then pass data to json
      def present!(options, **)
        data = { data: { message: 'Pokemon added to pokedex', status: 200 } }
        options[:response] = data.to_json
      end
    end
  end
end
