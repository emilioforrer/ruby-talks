module Demo
  module Relations
    class Addresses < ROM::Relation[:sql]
      schema(:addresses, infer: true) do
        associations do
          belongs_to :contact
        end
      end
    end
  end
end