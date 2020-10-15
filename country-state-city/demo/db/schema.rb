# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_06_011335) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "uuid"
    t.text "description"
    t.integer "contact_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contact_id"], name: "index_addresses_on_contact_id"
    t.index ["uuid"], name: "index_addresses_on_uuid"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "uuid"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_contacts_on_name"
    t.index ["uuid"], name: "index_contacts_on_uuid"
  end

  create_table "emails", force: :cascade do |t|
    t.string "uuid"
    t.string "account"
    t.integer "contact_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account"], name: "index_emails_on_account"
    t.index ["contact_id"], name: "index_emails_on_contact_id"
    t.index ["uuid"], name: "index_emails_on_uuid"
  end

  create_table "phones", force: :cascade do |t|
    t.string "uuid"
    t.string "number"
    t.integer "contact_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contact_id"], name: "index_phones_on_contact_id"
    t.index ["number"], name: "index_phones_on_number"
    t.index ["uuid"], name: "index_phones_on_uuid"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "name", limit: 100
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "activation_state"
    t.string "activation_token"
    t.datetime "activation_token_expires_at"
    t.integer "failed_logins_count", default: 0
    t.datetime "lock_expires_at"
    t.string "unlock_token"
    t.index ["activation_token"], name: "index_users_on_activation_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token"
  end

  create_table "v1_cities", force: :cascade do |t|
    t.bigint "state_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_v1_cities_on_name"
    t.index ["state_id"], name: "index_v1_cities_on_state_id"
  end

  create_table "v1_countries", force: :cascade do |t|
    t.string "iso_name"
    t.string "iso"
    t.string "iso3"
    t.string "name"
    t.string "sp_name"
    t.string "numcode"
    t.bigint "region_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["region_id"], name: "index_v1_countries_on_region_id"
  end

  create_table "v1_states", force: :cascade do |t|
    t.bigint "country_id"
    t.string "name"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_id"], name: "index_v1_states_on_country_id"
    t.index ["name"], name: "index_v1_states_on_name"
  end

  create_table "v2_cities", force: :cascade do |t|
    t.bigint "state_id"
    t.string "state_code"
    t.bigint "country_id"
    t.string "country_code"
    t.string "name"
    t.string "latitude"
    t.string "longitude"
    t.index ["country_code"], name: "index_v2_cities_on_country_code"
    t.index ["country_id"], name: "index_v2_cities_on_country_id"
    t.index ["latitude"], name: "index_v2_cities_on_latitude"
    t.index ["longitude"], name: "index_v2_cities_on_longitude"
    t.index ["name"], name: "index_v2_cities_on_name"
    t.index ["state_code"], name: "index_v2_cities_on_state_code"
    t.index ["state_id"], name: "index_v2_cities_on_state_id"
  end

  create_table "v2_countries", force: :cascade do |t|
    t.string "name"
    t.string "iso3"
    t.string "iso2"
    t.string "phone_code"
    t.string "capital"
    t.string "currency"
    t.string "native"
    t.string "emoji"
    t.string "emojiU"
    t.index ["name"], name: "index_v2_countries_on_name"
  end

  create_table "v2_states", force: :cascade do |t|
    t.bigint "country_id"
    t.string "name"
    t.string "country_code"
    t.string "state_code"
    t.index ["country_code"], name: "index_v2_states_on_country_code"
    t.index ["country_id"], name: "index_v2_states_on_country_id"
    t.index ["name"], name: "index_v2_states_on_name"
    t.index ["state_code"], name: "index_v2_states_on_state_code"
  end

end
