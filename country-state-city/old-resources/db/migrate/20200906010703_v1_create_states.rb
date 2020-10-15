class V1CreateStates < ActiveRecord::Migration[6.0]
  def change
    create_table :v1_states do |t|
      t.references    :country
      t.string        :name, index: true
      t.datetime      :deleted_at
      t.timestamps
    end
  end
end
