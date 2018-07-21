# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180721172455) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conditions", force: :cascade do |t|
    t.datetime "date"
    t.float "max_temperature"
    t.float "mean_temperature"
    t.float "min_temperature"
    t.float "mean_humidity"
    t.float "mean_visibility"
    t.float "mean_wind_speed"
    t.float "precipitation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stations", force: :cascade do |t|
    t.string "name"
    t.integer "dock_count"
    t.string "city"
    t.datetime "installation_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.bigint "station_id"
    t.integer "bikes_available"
    t.integer "docks_available"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["station_id"], name: "index_statuses_on_station_id"
  end

  create_table "trips", force: :cascade do |t|
    t.integer "duration"
    t.datetime "start_date"
    t.integer "start_station_id"
    t.datetime "end_date"
    t.integer "end_station_id"
    t.integer "bike_id"
    t.integer "subscription_type"
    t.integer "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "statuses", "stations"
end
