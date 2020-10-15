module V2
  class City < ActiveRecord::Base
    self.table_name = "v2_cities"
    belongs_to :state, class_name: "V2::State"
  end
end
