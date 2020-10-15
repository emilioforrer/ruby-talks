class CreatePhones < ActiveRecord::Migration[6.0]
  def change
    create_table :phones do |t|
      t.string      :uuid, index: true, unique: true
      t.string      :number, index: true
      t.integer     :contact_id, index: true
      t.timestamps
    end
  end
end
