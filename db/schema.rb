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

ActiveRecord::Schema.define(version: 20170918205503) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "cube"
  enable_extension "earthdistance"

  create_table "auth_tokens", force: :cascade do |t|
    t.string   "value"
    t.datetime "expired_at"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_auth_tokens_on_user_id", using: :btree
  end

  create_table "event_users", id: false, force: :cascade do |t|
    t.integer "event_id"
    t.integer "user_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer  "place_id"
    t.integer  "kind",       default: 0
    t.datetime "start_time"
    t.string   "title"
    t.integer  "invites",    default: [],              array: true
    t.integer  "author_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["place_id"], name: "index_events_on_place_id", using: :btree
  end

  create_table "place_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "place_id"
    t.integer  "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_place_users_on_place_id", using: :btree
    t.index ["user_id"], name: "index_place_users_on_user_id", using: :btree
  end

  create_table "places", force: :cascade do |t|
    t.float    "lat"
    t.float    "lng"
    t.string   "name"
    t.string   "place_id"
    t.string   "tags",           default: [],              array: true
    t.string   "city"
    t.float    "overall_rating"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index "ll_to_earth(lat, lng)", name: "places_earthdistance_ix", using: :gist
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "gender",              default: 0
    t.datetime "birthday"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index "ll_to_earth(lat, lng)", name: "users_earthdistance_ix", using: :gist
  end

  add_foreign_key "auth_tokens", "users"
  add_foreign_key "events", "places"
end
