class AddSessionToReminders < ActiveRecord::Migration
  def change
  	add_column :reminders,  :session_id, :string
  end
end
