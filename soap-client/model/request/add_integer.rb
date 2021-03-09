module Model
  module Request
    class AddInteger

      attr_accessor :arg_1, :arg_2

      def initialize(arg_1, arg_2)
        @arg_1 = arg_1
        @arg_2 = arg_2
      end

      def to_message
        {
          'Arg1' => @arg_1,
          'Arg2' => @arg_2
        }
      end
    end
  end
end