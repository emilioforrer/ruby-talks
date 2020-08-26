# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :addresses do
      primary_key :id
      foreign_key :contact_id, :contacts
      column :uuid, String, null: false, unique: true
      column :description, String, null: false, index: true
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
