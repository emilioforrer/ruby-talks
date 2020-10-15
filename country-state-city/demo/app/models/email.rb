class Email < ApplicationRecord
  include ::Common
  belongs_to :contact
end
