# frozen_string_literal: true

module Api
  module V1
    # Interact with pokedex controller
    class PokedexesController < Api::V1::ApplicationController
      skip_before_action :require_data!, only: [:add_pokemon]

      Paw::SwaggerDoc.endpoint(
        path: 'api/v1/pokemons/:pokemon_id/pokedexes/add_pokemon',
        method: 'post',
        summary: 'Pokedex - Add pokemon to pokedex',
        tags: [
          'api/v1/pokedexes'
        ],
        success_status: 200,
        error_responses: [401, 422, 500]
      )

      def add_pokemon
        result = Operations::Pokedex::AddPokemon.call(
          create_options
        )
        render json: result[:response]
      end

      def create
        result = Operations::Pokedex::AddPokemon.call(
          create_options
        )
        render json: result[:response]
      end

      private

      def create_options
        {
          params: params,
          current_user: current_user
        }
      end
    end
  end
end
