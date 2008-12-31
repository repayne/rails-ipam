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

ActiveRecord::Schema.define(:version => 20081230183438) do

  create_table "ip_historians", :force => true do |t|
    t.string   "ip_address",  :null => false
    t.string   "hostname"
    t.string   "a_rec"
    t.string   "ptr_rec"
    t.string   "description"
    t.text     "notes"
    t.boolean  "pingable",    :null => false
    t.boolean  "reserved",    :null => false
    t.boolean  "allocated",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ips", :force => true do |t|
    t.string   "ip_address",                     :null => false
    t.string   "hostname"
    t.string   "a_rec"
    t.string   "ptr_rec"
    t.string   "description"
    t.text     "notes"
    t.boolean  "pingable",    :default => false, :null => false
    t.boolean  "reserved",    :default => false, :null => false
    t.boolean  "allocated",   :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
