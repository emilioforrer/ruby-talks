class V2CreateCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :v2_countries do |t|
      t.string     :name, index: true
      t.string     :iso3
      t.string     :iso2
      t.string     :phone_code
      t.string     :capital
      t.string     :currency
      t.string     :native
      t.string     :emoji
      t.string     :emojiU
      # t.timestamps null: false
    end
  end
end