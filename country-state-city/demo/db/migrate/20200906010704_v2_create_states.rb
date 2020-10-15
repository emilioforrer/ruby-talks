class V2CreateStates < ActiveRecord::Migration[6.0]
  def change
    create_table :v2_states do |t|
      t.references    :country, index: true
      t.string        :name, index: true
      t.string        :country_code, index: true
      t.string        :state_code, index: true
      # t.timestamps    null: false
    end
  end
end

