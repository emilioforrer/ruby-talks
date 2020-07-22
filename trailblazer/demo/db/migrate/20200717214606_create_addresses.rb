class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string      :uuid, index: true, unique: true
      t.text        :description
      t.integer     :contact_id, index: true
      t.timestamps
    end
  end
end
