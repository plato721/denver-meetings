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

ActiveRecord::Schema.define(version: 20151111043722) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "meetings", force: :cascade do |t|
    t.string   "day"
    t.string   "group_name"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "notes"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "district"
    t.string   "codes"
    t.decimal  "lat",            precision: 10, scale: 6
    t.decimal  "lng",            precision: 10, scale: 6
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "raw_meeting_id"
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
