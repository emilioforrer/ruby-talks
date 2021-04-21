# frozen_string_literal: true

module CustomTokenErrorResponse
  #  Override the body response
  # @return [JSON] if a single object was returned
  #   from the database.
  # :nocov:
  def body
    {
      errors: [
        {
          code: 400,
          field_name: 'base',
          message: 'Invalid token or grant type'
        }
      ]
    }
    # or merge with existing values by
    # super.merge({key: value})
  end
  # :nocov:
end
