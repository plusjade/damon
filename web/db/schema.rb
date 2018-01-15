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

ActiveRecord::Schema.define(version: 20180115012636) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "entries", id: :serial, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "value"
    t.string "old_category"
    t.string "ordinal"
    t.datetime "occurred_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id", null: false
    t.index ["occurred_at"], name: "index_entries_on_occurred_at"
    t.index ["user_id"], name: "index_entries_on_user_id"
  end

  create_table "prompts", id: :serial, force: :cascade do |t|
    t.string "key"
    t.string "prompt"
    t.string "custom_prompt"
    t.text "choices", default: [], array: true
    t.integer "position"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_prompts_on_category_id"
    t.index ["key", "category_id"], name: "index_prompts_on_key_and_category_id", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "google_sub", null: false
    t.text "access_token", null: false
    t.string "given_name"
    t.string "avatar_url"
    t.string "signup_category"
    t.index ["email"], name: "index_users_on_email"
  end

  create_table "videos", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "token"
    t.text "payload"
    t.string "audio_url"
    t.string "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_videos_on_token"
  end

end
