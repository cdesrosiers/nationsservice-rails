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

ActiveRecord::Schema.define(:version => 20120413151751) do

  create_table "locations", :force => true do |t|
    t.string   "country",    :default => ""
    t.string   "state",      :default => ""
    t.string   "city",       :default => ""
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "locations", ["city"], :name => "index_locations_on_city"
  add_index "locations", ["country", "state", "city"], :name => "index_locations_on_country_and_state_and_city", :unique => true
  add_index "locations", ["country"], :name => "index_locations_on_country"
  add_index "locations", ["state"], :name => "index_locations_on_state"

  create_table "placements", :force => true do |t|
    t.integer  "placeable_id"
    t.string   "placeable_type"
    t.integer  "location_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "placements", ["location_id"], :name => "index_placements_on_location_id"
  add_index "placements", ["placeable_id", "placeable_type", "location_id"], :name => "uniqueness_index", :unique => true
  add_index "placements", ["placeable_id"], :name => "index_placements_on_placeable_id"

  create_table "positions", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.date     "deadline"
    t.integer  "poster_id"
    t.integer  "position_type", :limit => 2
    t.integer  "duration",      :limit => 2
    t.string   "overview",      :limit => 2047
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "gradyear"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["gradyear"], :name => "index_users_on_gradyear"
  add_index "users", ["name"], :name => "index_users_on_name"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
