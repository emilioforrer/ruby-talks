module Demo
  module Relations
    class Contacts < ROM::Relation[:sql]
      schema(:contacts, infer: true) do
        associations do
          has_many :emails
          has_many :phones
          has_many :addresses
        end
      end

      def sorted
        order(:name)
      end

      def starred
        where(starred: true).order(:name)
      end
    end
  end
end