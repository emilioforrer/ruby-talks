class ApplicationController < ActionController::API
  include Paw::Concerns::Controllers::ErrorHandlersConcern
  include Paw::Concerns::Controllers::CrudConcern
  class_attribute :allowed_includes, :allowed_sorts
  self.allowed_includes = []
  self.allowed_sorts = []
  before_action :require_data!, except: [:index, :show, :destroy]

  private

  def current_user
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
