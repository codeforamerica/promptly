class AddReminderIdToNotifications < ActiveRecord::Migration
  def change
  	add_column :notifications, :reminder_id, :integer
  	remove_column :notifications, :report_id
  end
end
