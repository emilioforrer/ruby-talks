class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :access_tokens,
           class_name: 'Doorkeeper::AccessToken',
           foreign_key: :resource_owner_id,
           dependent: :delete_all 
           
  def self.authenticate(email, password)
    user = User.find_by(email: email)
    user.try(:valid_password?, password) ? user : nil
  end
end
