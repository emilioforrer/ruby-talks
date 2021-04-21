# frozen_string_literal: true

module Api
  module V1
    # Interact with pokemons controller
    class PokemonsController < Api::V1::ApplicationController
      self.allowed_sorts = %w[name generation]
      Paw::SwaggerDoc.endpoint(
        path: 'api/v1/pokemons',
        method: 'get',
        collection: true,
        allowed_includes: allowed_includes,
        allowed_sorts: allowed_sorts,
        summary: 'Pokemons - List Pokemons',
        tags: [
          'api/v1/pokemons'
        ],
        success_status: 200,
        error_responses: [401, 500],
        presenter: Presenters::PokemonPresenter
      )

      def index
        result = Paw::Operations::Api::Finder.call(
          **fetch_options
        )
        render json: result[:response]
      end

      def show
        result = Paw::Operations::Api::Finder.call(
          **fetch_options
        )
        render json: result[:response]
      end

      private

      def fetch_options
        {
          params: params,
          model_identifier: :id,
          model_class: Pokemon,
          allowed_sorts: self.class.allowed_sorts,
          presenter_class: Presenters::PokemonPresenter
        }
      end
    end
  end
end
