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

ActiveRecord::Schema.define(:version => 20120612231712) do

  create_table "categories", :force => true do |t|
    t.integer  "budget",                   :null => false
    t.string   "name",       :limit => 50, :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "categories", ["name"], :name => "index_categories_on_name", :unique => true

  create_table "goals", :force => true do |t|
    t.string   "name",       :limit => 50, :null => false
    t.integer  "cost",                     :null => false
    t.integer  "rank",                     :null => false
    t.boolean  "purchased",                :null => false
    t.integer  "user_id",                  :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "goals", ["name"], :name => "index_goals_on_name", :unique => true
  add_index "goals", ["rank"], :name => "index_goals_on_rank", :unique => true

  create_table "transactions", :force => true do |t|
    t.integer  "amount",                         :null => false
    t.text     "description"
    t.integer  "category_id"
    t.date     "transaction_date",               :null => false
    t.integer  "user_id",                        :null => false
    t.string   "type",             :limit => 20, :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name",            :null => false
    t.string   "email",           :null => false
    t.string   "password_digest", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

  add_foreign_key "goals", "users", :name => "goals_user_id_fk", :dependent => :delete

  add_foreign_key "transactions", "categories", :name => "transactions_category_id_fk", :dependent => :nullify
  add_foreign_key "transactions", "users", :name => "transactions_user_id_fk", :dependent => :delete

end
