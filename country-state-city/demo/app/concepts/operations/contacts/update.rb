module Operations
  module Contacts
    class Update < Operations::Api::Form

      step :find!
      step :contract!
      step :validate!
      step :persist!
      pass :ensure_presenter_class!
      step :present!
      fail :not_found!
      fail :error_with_params!
      fail :error_with_contract!
      # TODO: Tasks for the talk:
      # * Refactor this contract
      # * Add Nested models association

      def find!(ctx, params:, **)
        ctx[:model] = ::Contact.find_by(uuid: params[:id])
      end

      def contract!(ctx, model:, **)
        ctx[:contract] = Contracts::Contacts::Update.new(model)
      end

      def validate!(ctx, data:, contract:, **)
        contract.validate(data)
      end

      def persist!(ctx, contract:, **)
        contract.save
      end

      def ensure_presenter_class!(ctx, **)
        raise ArgumentError, "Option presenter_class is required" if ctx[:presenter_class].nil?
      end

      def present!(ctx, presenter_class:, model:, **)
        ctx[:response] = presenter_class.new(model)
      end

      def not_found!(ctx, params:, **)
        if ctx[:model].blank?
          ctx[:errors] = {base: ["Not found"]}
        end
      end

      def error_with_params!(ctx, params:, **)
        if params[:data].blank?
          ctx[:errors] = {base: ["No data parameter"]}
        end
      end

      def error_with_contract!(ctx, **)
        if ctx[:contract]&.errors&.present?
          ctx[:errors] = ctx[:contract].errors.messages
        end
      end
    end
  end
end