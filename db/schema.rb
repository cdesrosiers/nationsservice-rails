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

ActiveRecord::Schema.define(:version => 20120411040350) do

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

  add_index "institutions", ["state"], :name => "index_institutions_on_state"

  create_table "positions", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "location_city"
    t.string   "location_state"
    t.string   "location_country"
    t.date     "deadline"
    t.string   "logo_path"
    t.integer  "position_type"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "posted_by"
    t.string   "duration",         :limit => nil
    t.integer  "institution_id"
    t.integer  "campus_id"
  end

  add_index "positions", ["duration"], :name => "index_positions_on_duration"
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
  end

  add_index "users", ["campus_id"], :name => "index_users_on_campus_id"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["institution_id"], :name => "index_users_on_institution_id"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
