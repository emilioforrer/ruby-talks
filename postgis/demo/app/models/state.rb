class State < ActiveRecord::Base
  belongs_to :country
  has_many :cities,  :dependent => :destroy
  scope :by_country, lambda{|i| where{country_id == i}}
  scope :order_by_name, -> { order("name ASC") }
end