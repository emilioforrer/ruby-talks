module Common
  extend ActiveSupport::Concern

  included do
    before_save :set_uuid
  end

  def set_uuid
    self.uuid = SecureRandom.uuid if uuid.blank?
  end
end
