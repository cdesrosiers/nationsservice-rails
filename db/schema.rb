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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120416210653) do

  create_table "campus", :force => true do |t|
    t.string   "name"
    t.integer  "institution_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "campus", ["institution_id"], :name => "index_campus_on_institution_id"

  create_table "institutions", :force => true do |t|
    t.string   "name"
    t.string   "state"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "institutions", ["name", "state"], :name => "index_institutions_on_name_and_state", :unique => true
  add_index "institutions", ["state"], :name => "index_institutions_on_state"

  create_table "locales", :force => true do |t|
    t.string   "country"
    t.string   "province"
    t.string   "city"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "locales", ["city"], :name => "index_locales_on_city"
  add_index "locales", ["country", "province", "city"], :name => "index_locales_on_country_and_province_and_city", :unique => true
  add_index "locales", ["country"], :name => "index_locales_on_country"
  add_index "locales", ["province"], :name => "index_locales_on_province"

  create_table "placements", :force => true do |t|
    t.integer  "position_id"
    t.integer  "locale_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "placements", ["locale_id"], :name => "index_placements_on_locale_id"
  add_index "placements", ["position_id", "locale_id"], :name => "index_placements_on_position_id_and_locale_id", :unique => true
  add_index "placements", ["position_id"], :name => "index_placements_on_position_id"

  create_table "positions", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.date     "deadline"
    t.string   "logo_path"
    t.integer  "position_type"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "posted_by"
    t.integer  "institution_id"
    t.integer  "campus_id"
    t.integer  "duration",       :limit => 2
  end

  add_index "positions", ["institution_id"], :name => "index_positions_on_institution_id"
  add_index "positions", ["posted_by"], :name => "index_positions_on_posted_by"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
    t.integer  "institution_id"
    t.integer  "campus_id"
    t.integer  "gradyear"
  end

  add_index "users", ["campus_id"], :name => "index_users_on_campus_id"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["institution_id"], :name => "index_users_on_institution_id"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
