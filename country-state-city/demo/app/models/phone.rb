class Phone < ApplicationRecord
  include ::Common
  belongs_to :contact
end
