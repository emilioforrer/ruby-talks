class CreateCountries < ActiveRecord::Migration[6.0]
  def change
    # TODO: Add indexes
    create_table :countries do |t|
      t.string     :name, index: true
      t.string     :iso3
      t.string     :iso2
      t.string     :phone_code
      t.string     :capital
      t.string     :currency
      t.string     :native
      t.string     :emoji
      t.string     :emojiU
    end
  end
end