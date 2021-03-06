# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090723114025) do

  create_table "results", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string "name", :null => false
  end

  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "scores", :force => true do |t|
    t.integer  "score",      :limit => 11
    t.integer  "team_id",    :limit => 11, :null => false
    t.integer  "result_id",  :limit => 11, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seasons", :force => true do |t|
    t.string   "name",                           :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",     :default => "open"
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.integer  "user_id",    :limit => 11, :null => false
    t.integer  "season_id",  :limit => 11, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string  "name"
    t.string  "hashed_password", :limit => 40
    t.string  "email"
    t.boolean "email_confirmed",               :default => false
  end

  create_table "users_roles", :force => true do |t|
    t.integer "user_id", :limit => 11, :null => false
    t.integer "role_id", :limit => 11, :null => false
  end

end
