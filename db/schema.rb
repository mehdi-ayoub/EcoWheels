# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_09_06_053250) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "shipments", force: :cascade do |t|
    t.string "city"
    t.float "distance_traveled"
    t.string "vehicle_type"
    t.string "fuel_type"
    t.float "fuel_consumption"
    t.string "product_name"
    t.date "shipment_start"
    t.date "shipment_end"
    t.float "co2_emissions"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "start_location"
    t.string "end_location"
    t.float "start_latitude"
    t.float "start_longitude"
    t.float "end_latitude"
    t.float "end_longitude"
    t.index ["user_id"], name: "index_shipments_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "shipments", "users"
end
