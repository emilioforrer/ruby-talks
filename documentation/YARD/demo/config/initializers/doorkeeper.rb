# frozen_string_literal: true

Doorkeeper.configure do
  # Change the ORM that doorkeeper will use (requires ORM extensions installed).
  # Check the list of supported ORMs here: https://github.com/doorkeeper-gem/doorkeeper#orms
  orm :active_record

  # This block will be called to check whether the resource owner is authenticated or not.
  resource_owner_authenticator do
    # raise "Please configure doorkeeper resource_owner_authenticator block located in #{__FILE__}"
    # Put your resource owner authentication logic here.
    # Example implementation:
    #   User.find_by(id: session[:user_id]) || redirect_to(new_user_session_url)
  end

  resource_owner_from_credentials do |_routes|
    User.authenticate(params[:email], params[:password])
  end

  grant_flows %w[password]

  # token expiration
  access_token_expires_in ENV.fetch('TOKEN_EXPIRATION', '120').to_i.minutes

  # use_refresh_token
  use_refresh_token revoke_on_refresh: true

  skip_client_authentication_for_password_grant true
  # skip_authorization do
  #   true
  # end
end
