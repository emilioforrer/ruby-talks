class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :name, null: false
      t.geometry :area
      t.st_point :coords, null: false, geographic: true
      t.index :coords, using: :gist
      t.timestamps
    end
  end
end
