module Contracts
  module Contacts
    class Update < Reform::Form
      property :name  
      validates :name,  presence: true
    end
  end
end