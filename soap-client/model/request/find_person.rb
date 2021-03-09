module Model
  module Request
    class FindPerson

      attr_accessor :id

      def initialize(id)
        @id = id
      end

      def to_message
        {
          'id' => @id,
        }
      end
    end
  end
end