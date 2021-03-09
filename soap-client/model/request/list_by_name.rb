module Model
  module Request
    class ListByName

      attr_accessor :name

      def initialize(name)
        @name = name
      end

      def to_message
        {
          'name' => @name,
        }
      end
    end
  end
end