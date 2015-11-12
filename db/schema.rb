ActiveRecord::Schema.define(version: 20151112215541) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "citext"

  create_table "meetings", force: :cascade do |t|
    t.string   "day"
    t.citext   "group_name"
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

  create_table "search_requests", force: :cascade do |t|
    t.string "text"
    t.string "city"
    t.string "name"
    t.string "time"
    t.string "open"
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
