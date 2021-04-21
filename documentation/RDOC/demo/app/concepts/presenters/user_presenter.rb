module Presenters
  # User Presenter
  class UserPresenter < Paw::Presenters::Api::BasePresenter
    property :id, documentation: { type: :integer }
    property :first_name
    property :last_name
    property :email
  end
end
