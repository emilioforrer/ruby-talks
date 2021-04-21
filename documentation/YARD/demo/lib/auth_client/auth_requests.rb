module AuthClient
  # @abstract AuthClient::AuthRequests and override {#profile} to implement
  #  the auth request
  module AuthRequests
    # :nocov:
    def profile
      raise NotImplementedError, 'Please override this method.'
    end
    # :nocov:
  end
end
