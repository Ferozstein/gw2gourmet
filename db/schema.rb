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

ActiveRecord::Schema.define(version: 20140425233519) do

  create_table "comments", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_strings", force: true do |t|
    t.string   "contents"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_id"
  end

  create_table "items", force: true do |t|
    t.integer  "item_no"
    t.string   "name"
    t.text     "description"
    t.string   "item_type"
    t.integer  "level"
    t.string   "rarity"
    t.integer  "vendor_value"
    t.string   "icon_file_id"
    t.string   "icon_file_signature"
    t.string   "default_skin"
    t.text     "game_types"
    t.text     "flags"
    t.text     "restrictions"
    t.text     "type_elements"
    t.text     "crafting"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "recipe_no"
    t.string   "craft_mat"
  end

  create_table "recipes", force: true do |t|
    t.integer  "recipe_no"
    t.string   "recipe_type"
    t.integer  "output_item_no"
    t.integer  "output_item_count"
    t.integer  "min_rating"
    t.integer  "time_to_craft_ms"
    t.string   "disciplines"
    t.string   "flags"
    t.string   "ingredients"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "votes", force: true do |t|
    t.integer  "value"
    t.integer  "user_id"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
