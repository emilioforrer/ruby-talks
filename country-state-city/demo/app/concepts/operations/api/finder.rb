module Operations
  module Api
    class Finder < Trailblazer::Operation
      step :extract_filter!
      pass :ensure_model_class!
      step :find!
      pass :default_scope!
     
      def extract_filter!(ctx, params:, **)
        ctx[:filter] = params.fetch(:filter, {})
      end

      def ensure_model_class!(ctx, params:, **)
        raise ArgumentError, "Option model_class is required" if ctx[:model_class].nil?
      end

      def find!(ctx, model_class:, **)
        ctx[:models] = model_class.all
      end

      def default_scope!(ctx, model_class:, **)
        if ctx[:default_scope].respond_to?(:call)
          ctx[:models] = ctx[:default_scope].(ctx[:models])
        end
      end
      # TODO: Task for the talk:
      # * Add pagination, representer, etc.
    end
  end
end