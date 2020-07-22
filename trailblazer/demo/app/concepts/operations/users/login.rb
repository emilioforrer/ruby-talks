module Operations
  module Users
    class Login < Trailblazer::Operation
      step :extract_data!
      step :find!
      step :validate_active!
      step :validate_lock!
      step :validate_password!
      pass :present!
      fail :error!

      def extract_data!(ctx, params:, **)
        ctx[:data] = params.fetch(:data, {})
      end

      def find!(ctx, data:, **)
        ctx[:model] = User.find_by_email(data[:email])
      end

      def validate_active!(ctx, model:, **)
        model.activation_state == 'active'
      end

      def validate_lock!(ctx, model:, **)
        !model.login_locked?
      end

      def validate_password!(ctx, model:, data:, **)
        valid = model.valid_password?(data.fetch('password'))
        model.register_failed_login! unless valid
        valid
      end

      def present!(options, model:, **)
        if options[:presenter_enabled]
          options[:response] = model.to_json
        end
      end

      def error!(ctx, **)
        ctx[:error] = "Invalid credentials"
      end
    end
  end
end