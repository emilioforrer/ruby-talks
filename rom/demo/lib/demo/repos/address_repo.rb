module Demo
  module Repos
    class AddressRepo < ROM::Repository[:addresses]
      include Import["container"]

      commands :create,
        use: :timestamps,
        plugins_options: {
          timestamps: {
            timestamps: %i(created_at updated_at)
          }
        }
    end
  end
end