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

ActiveRecord::Schema.define(version: 20171113045806) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "content"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "open_id"
    t.string   "mobile"
    t.string   "email"
    t.string   "wx_user_name"
    t.string   "nick_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "users", ["open_id"], name: "index_users_on_open_id", using: :btree

  create_table "wechat_sessions", force: :cascade do |t|
    t.string   "openid",     null: false
    t.string   "hash_store"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "wechat_sessions", ["openid"], name: "index_wechat_sessions_on_openid", unique: true, using: :btree

end
