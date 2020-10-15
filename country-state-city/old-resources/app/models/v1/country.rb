module V1
  class Country < ActiveRecord::Base
    self.table_name = "v1_countries"
    has_many :states,  :dependent => :destroy
  
    scope :order_by_name, -> { order("name ASC") }
    scope :where_country_ids,  ->(cids){ where("id in (?)", cids) }
  end
end
