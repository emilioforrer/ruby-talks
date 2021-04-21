# frozen_string_literal: true

module AuthClient
  class AuthRequestClient < AuthClient::AuthRequestsClient
    include AuthRequests

    def initialize(_options = {})
      @base_url = ENV['AUTH0_URL']
      @conn = Faraday.new(url: @base_url)
    end

    def profile(auth_token)
      @conn.authorization(:Bearer, auth_token)
      response = @conn.get '/userinfo'
      result = body_json(response.body)
      if response.status == 401
        raise Paw::Exceptions::StandardError.new(
          message: 'Bad Token',
          status: 422,
          code: 422
        )
      else
        result
      end
    end

    private

    def body_json(json)
      HashWithIndifferentAccess.new((begin
        JSON.parse(json)
      rescue StandardError
        # :nocov:
        {}
        # :nocov:
      end))
    end
  end
end
