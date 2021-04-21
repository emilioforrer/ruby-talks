module Operations
  module Pokedex
    # Operation to remove pokemon from pokedex
    class RemovePokemon < Trailblazer::Operation
      delegate :error!, to: Paw::Utils
      pass :model!
      pass :delete!
      pass :present!

      # Method used to valid if pokemon exist on user pokedex
      def model!(options, params:, current_user:, **)
        options[:model] = ::Pokedex.find_by(pokemon_id: params[:pokemon_id], user_id: current_user.id)
        error!(status: 404, message: I18n.t('paw.api.messages.not_found')) if options[:model].nil?
      end

      # Method used to delete record
      def delete!(options, **)
        options[:model].destroy
      end

      # Method used to retrieve information to user
      # :markup: markdown
      # ``` ruby
      # TEST CLASS RUBY EXAMPLE 
      # data = { data: { message: 'Your pokemon was removed from pokedex', status: 200 } }
      # ```
      def present!(options, **)
        data = { data: { message: 'Your pokemon was removed from pokedex', status: 200 } }
        options[:response] = data.to_json
      end
    end
  end
end
