module Presenters
  class TypePresenter < Paw::Presenters::Api::BasePresenter
    property :id, documentation: { type: :integer }
    property :name
  end
end
