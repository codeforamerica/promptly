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


ActiveRecord::Schema.define(:version => 20130923214540) do

  create_table "conversations", :force => true do |t|
    t.datetime "date"
    t.text     "message"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "to_number"
    t.string   "from_number"
    t.string   "message_id"
    t.string   "status"
    t.string   "batch_id"
  end

  create_table "conversations_recipients", :id => false, :force => true do |t|
    t.integer "recipient_id"
    t.integer "conversation_id"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.string   "group_name_id"
    t.text     "description"
    t.boolean  "editable"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups_recipients", :id => false, :force => true do |t|
    t.integer "group_id",     :null => false
    t.integer "recipient_id", :null => false
  end

  add_index "groups_recipients", ["group_id", "recipient_id"], :name => "index_groups_recipients_on_group_id_and_recipient_id", :unique => true

  create_table "groups_reminders", :id => false, :force => true do |t|
    t.integer "group_id",    :null => false
    t.integer "reminder_id", :null => false
  end

  add_index "groups_reminders", ["group_id", "reminder_id"], :name => "index_groups_reminders_on_group_id_and_reminder_id", :unique => true

  create_table "messages", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "message_text"
    t.text     "description"
  end

  create_table "notifications", :force => true do |t|
    t.integer  "report_id"
    t.integer  "recipient_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "job_id"
    t.datetime "sent_date"
    t.integer  "reminder_id"
  end

  create_table "programs", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "reminder_id"
  end

  create_table "programs_recipients", :id => false, :force => true do |t|
    t.integer "recipient_id"
    t.integer "program_id"
  end

  create_table "recipients", :force => true do |t|
    t.string   "phone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
  end

  create_table "recipients_reports", :id => false, :force => true do |t|
    t.integer "recipient_id"
    t.integer "report_id"
  end

  create_table "reminders", :force => true do |t|
    t.string   "name"
    t.datetime "send_date"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "recipient_id"
    t.integer  "message_id"
    t.string   "batch_id"
    t.time     "send_time"
    t.integer  "job_id"
    t.string   "state"
    t.string   "session_id"
  end

  create_table "reports", :force => true do |t|
    t.text     "humanname"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "reminder_id"
    t.integer  "program_id"
    t.string   "report_type"
    t.integer  "message_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "roles_mask"
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
