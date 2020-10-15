class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string      :uuid, index: true, unique: true
      t.string      :name, index: true
      t.timestamps
    end
  end
end
