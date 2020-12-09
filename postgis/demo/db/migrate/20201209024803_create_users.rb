class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.text   :description, null: false
      t.st_point :coords, null: false, geographic: true
      t.index :coords, using: :gist
      t.timestamps
    end
  end
end
