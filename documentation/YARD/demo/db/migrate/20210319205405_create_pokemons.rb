class CreatePokemons < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.integer :total
      t.number :hp
      t.number :attack
      t.integer :defense
      t.integer :generation
      t.boolean :legendary
      t.references :types, null: false, foreign_key: true

      t.timestamps
    end
  end
end
