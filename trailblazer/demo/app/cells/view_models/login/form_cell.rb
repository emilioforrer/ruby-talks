module ViewModels
  module Login
    class FormCell  < ::ViewModels::Base
      def data
        OpenStruct.new(params.fetch(:data, {}))
      end
    end
  end
end