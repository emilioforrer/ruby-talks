module Operations
  module Contacts
    class Create < Operations::Api::Form

      step Model( Contact, :new )
      step Contract::Build(constant: Contracts::Contacts::Create)
      step Contract::Validate(key: "data")
      step Contract::Persist()
      pass :ensure_presenter_class!
      step :present!
      fail :error!
      fail :error_with_params!

      def ensure_presenter_class!(ctx, **)
        raise ArgumentError, "Option presenter_class is required" if ctx[:presenter_class].nil?
      end

      def present!(ctx, presenter_class:, model:, **)
        
        ctx[:response] = presenter_class.new(model)
      end

      def error!(ctx, params:, **)
        ctx[:errors] = ctx[:"contract.default"].errors.messages
      end

      def error_with_params!(ctx, params:, **)
        if params[:data].blank?
          ctx[:errors] = {base: ["No data parameter"]}
        end
      end
    end
  end
end