APP_ROOT = File.expand_path('../../', __FILE__)

ENV['APP_ENV'] ||= "development"

ENV['BUNDLE_GEMFILE'] ||= File.join(APP_ROOT, '/', 'Gemfile')

require "bundler"
Bundler.require(:default, ENV["APP_ENV"])


require "dotenv"
Dotenv.load(".env", ".env.#{ENV["APP_ENV"]}")

require 'securerandom'
