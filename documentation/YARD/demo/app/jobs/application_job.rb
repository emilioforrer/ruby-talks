class ApplicationJob < ActiveJob::Base
  private

  def logger
    @logger ||= Logger.new(Rails.root.join('log', 'jobs.log'))
  end
end
