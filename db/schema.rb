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

ActiveRecord::Schema.define(version: 2019_09_21_064503) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "country_maps", force: :cascade do |t|
    t.string "ip"
    t.string "country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ip"], name: "index_country_maps_on_ip"
  end

  create_table "visits", force: :cascade do |t|
    t.string "domain"
    t.string "ip"
    t.string "device"
    t.string "country"
    t.string "referer"
    t.string "keyword"
    t.boolean "bounce"
    t.integer "retention"
    t.string "browser"
    t.string "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "path"
  end

end
