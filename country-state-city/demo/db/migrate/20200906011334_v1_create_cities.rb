class V1CreateCities < ActiveRecord::Migration[6.0]
  def change
    create_table :v1_cities do |t|
      t.references :state
      t.string  :name, index: true
      t.timestamps
    end
  end
end
