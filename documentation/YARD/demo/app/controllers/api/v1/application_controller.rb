class Api::V1::ApplicationController < ApplicationController
  before_action :doorkeeper_authorize!
end
