module Presenters
  # Pokemons Presenter
  class PokemonPresenter < Paw::Presenters::Api::BasePresenter
    property :id, documentation: { type: :integer }
    property :name
    property :total, documentation: { type: :integer }
    property :hp, documentation: { type: :integer }
    property :attack, documentation: { type: :integer }
    property :defense, documentation: { type: :integer }
    property :speed, documentation: { type: :integer }
    property :generation, documentation: { type: :integer }
    property :legendary, documentation: { type: :boolean }
    property :type, decorator: TypePresenter
  end
end
