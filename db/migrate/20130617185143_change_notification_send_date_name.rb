class ChangeNotificationSendDateName < ActiveRecord::Migration
  def up
  	change_table :notifications do |t|
  		t.remove "send_date"
  		t.datetime "sent_date"
  	end
  end

  def down
  	change_table :notifications do |t|
  		t.remove "send_date"
  		t.datetime "sent_date"
  	end
  end
end
