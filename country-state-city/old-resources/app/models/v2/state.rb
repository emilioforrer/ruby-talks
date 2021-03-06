module V2
  class State < ActiveRecord::Base
    self.table_name = "v2_states"
    belongs_to :country, class_name: "V2::Country"
    has_many :cities,  :dependent => :destroy
    scope :by_country, lambda{|i| where{country_id == i}}
    scope :order_by_name, -> { order("name ASC") }
  end
end
