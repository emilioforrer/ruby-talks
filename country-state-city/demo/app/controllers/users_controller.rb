class UsersController < ApplicationController
  def index
    @result = Operations::Users::List.(
      params: params,
      model_class: User,
      current_user: current_user
    )
  end
end
