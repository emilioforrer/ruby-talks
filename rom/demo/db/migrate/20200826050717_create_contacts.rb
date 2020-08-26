# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :contacts do
      primary_key :id
      column :uuid, String, null: false, unique: true
      column :name, String, null: false, index: true
      column :starred, TrueClass, default: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
      check{char_length(name) < 96}
    end
  end
end
