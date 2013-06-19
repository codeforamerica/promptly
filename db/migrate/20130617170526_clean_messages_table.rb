class CleanMessagesTable < ActiveRecord::Migration
  def up
  	change_table :messages do |t|
  		t.remove "messagetext"
  		t.remove "report_id"
  		t.remove "send_date"


	  # Original table
	  #   create_table "messages", :force => true do |t|
	  #   t.string   "type"
	  #   t.datetime "send_date"
	  #   t.datetime "created_at",   :null => false
	  #   t.datetime "updated_at",   :null => false
	  #   t.string   "message_text"
	  #   t.text     "messagetext"
	  #   t.integer  "report_id"
 	end
  end

  def down
  	change_table :messages do |t|
  		t.text "messagetext"
  		t.integer "report_id"
  		t.datetime "send_date"
  	end
  end
end
