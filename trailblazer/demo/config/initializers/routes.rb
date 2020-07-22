Rails.application.routes.default_url_options[:host] = ENV.fetch('PAW_HOST', 'localhost')
Rails.application.routes.default_url_options[:protocol] = ENV.fetch('PAW_PROTOCOL', 'http')
Rails.application.config.action_controller.default_url_options = Rails.application.routes.default_url_options