class Country < ActiveRecord::Base
  has_many :states,  :dependent => :destroy

  scope :order_by_name, -> { order("name ASC") }
  scope :where_country_ids,  ->(cids){ where("id in (?)", cids) }
end
