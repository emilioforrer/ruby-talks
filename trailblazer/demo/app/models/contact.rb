class Contact < ApplicationRecord
  include ::Common
  has_many :addresses
  has_many :phones
  has_many :emails
  # TODO: Task for the talk
  # * Add images to the contact
  # has_one_attached :image
  # has_many_attached :images
end
