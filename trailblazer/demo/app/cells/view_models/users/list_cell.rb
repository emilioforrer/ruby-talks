module ViewModels
  module Users
    class ListCell  < ::ViewModels::Base
      def filter
        OpenStruct.new(params.fetch(:filter, {}))
      end
    end
  end
end