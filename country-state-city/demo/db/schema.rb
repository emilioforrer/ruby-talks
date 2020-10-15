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

  create_table "cities", force: :cascade do |t|
    t.bigint "state_id"
    t.string "state_code"
    t.bigint "country_id"
    t.string "country_code"
    t.string "name"
    t.string "latitude"
    t.string "longitude"
    t.index ["country_code"], name: "index_cities_on_country_code"
    t.index ["country_id"], name: "index_cities_on_country_id"
    t.index ["latitude"], name: "index_cities_on_latitude"
    t.index ["longitude"], name: "index_cities_on_longitude"
    t.index ["name"], name: "index_cities_on_name"
    t.index ["state_code"], name: "index_cities_on_state_code"
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "iso3"
    t.string "iso2"
    t.string "phone_code"
    t.string "capital"
    t.string "currency"
    t.string "native"
    t.string "emoji"
    t.string "emojiU"
    t.index ["name"], name: "index_countries_on_name"
  end

  create_table "states", force: :cascade do |t|
    t.bigint "country_id"
    t.string "name"
    t.string "country_code"
    t.string "state_code"
    t.index ["country_code"], name: "index_states_on_country_code"
    t.index ["country_id"], name: "index_states_on_country_id"
    t.index ["name"], name: "index_states_on_name"
    t.index ["state_code"], name: "index_states_on_state_code"
  end

end
