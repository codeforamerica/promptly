class AddReminderIdToNotifications < ActiveRecord::Migration
  def change
  	add_column :notifications, :reminder_id, :integer
  end
end
