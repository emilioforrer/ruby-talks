class V1CreateCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :v1_countries do |t|
      t.string     :iso_name
      t.string     :iso
      t.string     :iso3
      t.string      :name
      t.string     :sp_name
      t.string     :numcode
      t.references :region
      t.datetime   :deleted_at
      t.timestamps
    end
  end
end
