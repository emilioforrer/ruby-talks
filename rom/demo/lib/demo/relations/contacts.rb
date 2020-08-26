module Demo
  module Relations
    class Contacts < ROM::Relation[:sql]
      schema(:contacts, infer: true)

      def sorted
        order(:name)
      end

      def starred
        where(starred: true).order(:name)
      end
    end
  end
end