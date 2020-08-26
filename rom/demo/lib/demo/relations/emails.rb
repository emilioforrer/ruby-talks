module Demo
  module Relations
    class Emails < ROM::Relation[:sql]
      schema(:emails, infer: true) do
        associations do
          belongs_to :contact
        end
      end
    end
  end
end