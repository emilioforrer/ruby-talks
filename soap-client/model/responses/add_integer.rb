module Model
  module Response
    class AddInteger

      attr_reader :result

      def initialize(result)
        @result = result
      end
    end

    class AddIntegerResponseBuilder
      def self.from_message(message)
        AddInteger.new(message[:add_integer_response][:add_integer_result])
      end
    end
  end
end