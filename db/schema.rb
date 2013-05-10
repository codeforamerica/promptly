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

ActiveRecord::Schema.define(:version => 20130509001321) do

  create_table "conversations", :force => true do |t|
    t.datetime "date"
    t.text     "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "notifications", :force => true do |t|
    t.integer  "report_id"
    t.integer  "recipient_id"
    t.datetime "send_date"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "programs", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "recipients", :force => true do |t|
    t.integer  "phone"
    t.integer  "case"
    t.boolean  "active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "recipients_reports", :id => false, :force => true do |t|
    t.integer "recipient_id"
    t.integer "report_id"
  end

  create_table "reports", :force => true do |t|
    t.string   "type"
    t.text     "humanname"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "report_type"
  end

end
