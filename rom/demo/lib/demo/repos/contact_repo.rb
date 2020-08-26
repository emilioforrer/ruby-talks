module Demo
  module Repos
    class ContactRepo < ROM::Repository[:contacts]
      include Import["container"]

      commands :create,
        use: :timestamps,
        plugins_options: {
          timestamps: {
            timestamps: %i(created_at updated_at)
          }
        }

      def all
        contacts.to_a
      end

      def starred_and_sorted
        contacts.starred.sorted
      end
    end
  end
end