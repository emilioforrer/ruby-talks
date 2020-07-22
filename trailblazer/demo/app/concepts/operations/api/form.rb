module Operations
  module Api
    class Form < Trailblazer::Operation
      step :extract_data!
      
      def extract_data!(ctx, params:, **)
        ctx[:data] = params.fetch(:data, {})
      end
    end
  end
end