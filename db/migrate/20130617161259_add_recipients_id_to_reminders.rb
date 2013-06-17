class AddRecipientsIdToReminders < ActiveRecord::Migration
  def up
  	change_table :reminders do |t|
  		t.integer :recipient_id
  	end
  end

  def down
  	change_table :reminders do |t|
  		t.remove :recipient_id
  	end
  end
end
