module Operations
  module Contacts
    class List < Operations::Api::Finder

      pass :ensure_presenter_class!
      step :present!

      def ensure_presenter_class!(ctx, **)
        raise ArgumentError, "Option presenter_class is required" if ctx[:presenter_class].nil?
      end

      def present!(ctx, presenter_class:, models:, **)
        ctx[:response] = presenter_class.for_collection
                                        .new(models)
      end
    end
  end
end