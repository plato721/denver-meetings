# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151117021205) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "citext"

  create_table "features", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "foci", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "formats", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meeting_features", force: :cascade do |t|
    t.integer "meeting_id"
    t.integer "feature_id"
  end

  create_table "meeting_foci", force: :cascade do |t|
    t.integer "meeting_id"
    t.integer "focus_id"
  end

  create_table "meeting_formats", force: :cascade do |t|
    t.integer "meeting_id"
    t.integer "format_id"
  end

  create_table "meeting_languages", force: :cascade do |t|
    t.integer "meeting_id"
    t.integer "language_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.string   "day"
    t.citext   "group_name"
    t.citext   "address_1"
    t.string   "address_2"
    t.citext   "notes"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "district"
    t.string   "codes"
    t.decimal  "lat",            precision: 10, scale: 6
    t.decimal  "lng",            precision: 10, scale: 6
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.integer  "raw_meeting_id"
    t.boolean  "approved",                                default: false
    t.decimal  "time"
  end

  add_index "meetings", ["raw_meeting_id"], name: "index_meetings_on_raw_meeting_id", using: :btree

  create_table "raw_meetings", force: :cascade do |t|
    t.string   "day"
    t.string   "group_name"
    t.string   "address"
    t.string   "city"
    t.string   "district"
    t.string   "codes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "time"
    t.string   "checksum"
  end

  create_table "raw_meetings_metadata", force: :cascade do |t|
    t.datetime "last_update"
  end

  create_table "searches", force: :cascade do |t|
    t.citext  "free"
    t.string  "city"
    t.string  "group_name"
    t.string  "day"
    t.string  "time"
    t.string  "open"
    t.boolean "here_and_now"
    t.decimal "lat"
    t.decimal "lng"
  end

  create_table "users", force: :cascade do |t|
    t.string   "uid"
    t.string   "nickname"
    t.string   "email"
    t.string   "name"
    t.string   "image"
    t.string   "token"
    t.integer  "role",       default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_foreign_key "meetings", "raw_meetings"
end
