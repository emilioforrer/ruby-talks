module AuthClient
  # @abstract AuthRequestClient and override {#initialize} to implement
  #  the auth request
  class AuthRequestsClient
    include AuthRequests
    attr_accessor :base_url

    # :nocov:
    def initialize
      raise NotImplementedError, 'Please override this method.'
    end
    # :nocov:
  end
end
