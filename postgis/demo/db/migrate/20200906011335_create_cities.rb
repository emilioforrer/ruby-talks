class CreateCities < ActiveRecord::Migration[6.0]
  def change
    create_table :cities do |t|
      t.references :state
      t.string     :state_code, index: true
      t.references :country
      t.string     :country_code, index: true
      t.string     :name, index: true
      t.string     :latitude, index: true
      t.string     :longitude, index: true
    end
  end
end
