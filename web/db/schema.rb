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

ActiveRecord::Schema.define(version: 20171127063913) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_categories_on_user_id", using: :btree
  end

  create_table "entries", force: :cascade do |t|
    t.integer  "users_id"
    t.text     "value"
    t.string   "old_category"
    t.string   "ordinal"
    t.datetime "occurred_at",  null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.bigint   "category_id"
    t.index ["occurred_at"], name: "index_entries_on_occurred_at", using: :btree
    t.index ["users_id"], name: "index_entries_on_users_id", using: :btree
  end

  create_table "videos", force: :cascade do |t|
    t.string   "name"
    t.string   "token"
    t.text     "payload"
    t.string   "audio_url"
    t.string   "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_videos_on_token", using: :btree
  end

end
