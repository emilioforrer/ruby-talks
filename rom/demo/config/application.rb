require_relative "boot"

require "dry/system/container"

module Demo
  class Application < Dry::System::Container
    configure do |config|
      config.root = File.expand_path('..', __dir__)
      config.default_namespace = 'demo'

      config.auto_register = 'lib'
    end

    load_paths!('lib')
  end
  Import = Dry::AutoInject(Application)
end