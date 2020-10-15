class CreateStates < ActiveRecord::Migration[6.0]
  def change
    create_table :states do |t|
      t.references    :country, index: true
      t.string        :name, index: true
      t.string        :country_code, index: true
      t.string        :state_code, index: true
    end
  end
end

