module V1
  class City < ActiveRecord::Base
    self.table_name = "v1_cities"
    belongs_to :state, class_name: "V1::State"
  end
end
