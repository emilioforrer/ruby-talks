class CreatePokedexes < ActiveRecord::Migration[6.1]
  def change
    create_table :pokedexes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :pokemon, null: false, foreign_key: true

      t.timestamps
    end
  end
end
