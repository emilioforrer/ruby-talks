module Operations
  module Pokemons
    # Operation to list captured pokemons
    class CapturedPokemons < Paw::Operations::Api::Finder
      def models!(options, current_user:, **)
        options[:models] = current_user.pokemons
      end
    end
  end
end
