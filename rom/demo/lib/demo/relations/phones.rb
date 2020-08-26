module Demo
  module Relations
    class Phones < ROM::Relation[:sql]
      schema(:phones, infer: true) do
        associations do
          belongs_to :contact
        end
      end
    end
  end
end