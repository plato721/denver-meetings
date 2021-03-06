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

ActiveRecord::Schema.define(version: 2019_06_13_113241) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.citext "address_1"
    t.string "address_2"
    t.citext "notes"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "district"
    t.decimal "lat", precision: 10, scale: 6
    t.decimal "lng", precision: 10, scale: 6
  end

  create_table "meetings", id: :serial, force: :cascade do |t|
    t.string "day"
    t.citext "group_name"
    t.string "phone"
    t.string "codes"
    t.decimal "lat", precision: 10, scale: 6
    t.decimal "lng", precision: 10, scale: 6
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "raw_meeting_id"
    t.boolean "approved", default: false
    t.decimal "time"
    t.boolean "visible", default: true
    t.boolean "deleted", default: false
    t.integer "flags", default: 0, null: false
    t.boolean "closed", default: false
    t.boolean "men", default: false
    t.boolean "women", default: false
    t.boolean "gay", default: false
    t.boolean "young_people", default: false
    t.boolean "speaker", default: false
    t.boolean "step", default: false
    t.boolean "big_book", default: false
    t.boolean "grapevine", default: false
    t.boolean "traditions", default: false
    t.boolean "candlelight", default: false
    t.boolean "beginners", default: false
    t.boolean "asl", default: false
    t.boolean "accessible", default: false
    t.boolean "non_smoking", default: false
    t.boolean "sitter", default: false
    t.boolean "spanish", default: false
    t.boolean "french", default: false
    t.boolean "polish", default: false
    t.integer "address_id"
    t.index ["raw_meeting_id"], name: "index_meetings_on_raw_meeting_id"
  end

  create_table "raw_meetings", id: :serial, force: :cascade do |t|
    t.string "day"
    t.string "group_name"
    t.string "address"
    t.string "city"
    t.string "district"
    t.string "codes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "time"
    t.string "checksum"
    t.integer "meeting_id"
  end

  create_table "raw_meetings_metadata", id: :serial, force: :cascade do |t|
    t.datetime "last_update"
  end

  create_table "searches", id: :serial, force: :cascade do |t|
    t.citext "free"
    t.string "city", default: "any"
    t.string "group_name", default: "any"
    t.string "day", default: "any"
    t.string "time", default: "any"
    t.string "open", default: "any"
    t.boolean "here_and_now", default: false
    t.decimal "lat", default: "39.742043"
    t.decimal "lng", default: "-104.991531"
    t.string "women", default: "show"
    t.string "men", default: "show"
    t.string "youth", default: "show"
    t.string "gay", default: "show"
    t.string "access", default: "show"
    t.string "non_smoking", default: "show"
    t.string "sitter", default: "show"
    t.string "spanish", default: "show"
    t.string "polish", default: "show"
    t.string "french", default: "show"
    t.boolean "is_location_search", default: false
    t.decimal "within_miles"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "username"
  end

  add_foreign_key "meetings", "raw_meetings"
end
