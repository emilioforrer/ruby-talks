module Operations
  module Pokedex
    class AddPokemon < Trailblazer::Operation
      delegate :error!, to: Paw::Utils
      pass :validate_pokemon!
      pass :validate_pokedex_size!
      pass :persist!
      pass :present!

      def validate_pokemon!(options, params:, **)
        options[:model] = Pokemon.find_by(id: params[:pokemon_id])
        error!(status: 404, message: I18n.t('paw.api.messages.not_found')) if options[:model].nil?
      end

      def validate_pokedex_size!(options, current_user:, **)
        options[:pokedex] = current_user.pokemon_ids

        error!(status: 403, message: 'User reached the maximum of pokemons allowed') if options[:pokedex].size >= 5
      end

      def persist!(options, current_user:, **)
        ::Pokedex.create(user_id: current_user.id, pokemon_id: options[:model].id)
      end

      def present!(options, **)
        data = { data: { message: 'Pokemon added to pokedex', status: 200 } }
        options[:response] = data.to_json
      end
    end
  end
end
