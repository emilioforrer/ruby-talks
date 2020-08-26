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

      def create_with_phones(contact)
        contacts.combine(:phones).command(:create, use: :timestamps,
          plugins_options: {
            timestamps: {
              timestamps: %i(created_at updated_at)
            }
          }
        ).call(contact)
      end
    end
  end
end