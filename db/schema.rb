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

ActiveRecord::Schema.define(version: 20160907151146) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "favorite_locations", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "address",    null: false
    t.float    "lat",        null: false
    t.float    "lng",        null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendships", force: :cascade do |t|
    t.string   "popular_model_type"
    t.integer  "popular_model_id"
    t.string   "friend_type"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["friend_id", "friend_type"], name: "index_friendships_on_friend_id_and_friend_type", using: :btree
    t.index ["popular_model_id", "popular_model_type"], name: "index_friendships_on_popular_model_id_and_popular_model_type", using: :btree
  end

  create_table "invitations", force: :cascade do |t|
    t.float    "sender_lat", null: false
    t.float    "sender_lng", null: false
    t.float    "guest_lat"
    t.float    "guest_lng"
    t.integer  "sender_id",  null: false
    t.integer  "guest_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "message"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "password_digest"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

end
