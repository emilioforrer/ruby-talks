class CreatePokemons < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemons do |t|
      t.string :name, index: { unique: true }
      t.integer :total
      t.integer :hp
      t.integer :attack
      t.integer :defense
      t.integer :speed
      t.integer :generation
      t.boolean :legendary
      t.references :type, null: false, foreign_key: true

      t.timestamps default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
