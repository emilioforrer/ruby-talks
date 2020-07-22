class Address < ApplicationRecord
  include ::Common
  belongs_to :contact
end
