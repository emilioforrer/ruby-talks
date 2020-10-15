class CreateEmails < ActiveRecord::Migration[6.0]
  def change
    create_table :emails do |t|
      t.string      :uuid, index: true, unique: true
      t.string      :account, index: true
      t.integer     :contact_id, index: true
      t.timestamps
    end
  end
end
