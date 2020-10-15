module Contracts
  module Contacts
    class Create < Reform::Form
      property :name  
      validates :name,  presence: true
    end
  end
end