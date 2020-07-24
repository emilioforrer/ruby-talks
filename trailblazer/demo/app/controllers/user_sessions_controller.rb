class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def index
    redirect_to login_path and return
  end

  def create
    result = Operations::Users::Login.(params: params)
    if result.success?
      login(result[:data].fetch(:email), result[:data].fetch(:password))
      redirect_to root_path and return
    else
      flash[:error] = result[:error] and render action: :new
    end
  end

  def destroy
    logout
    redirect_to root_url and return
  end
end
