class AddDescriptionToReminder < ActiveRecord::Migration
  def change
  	add_column :reminders, :description, :text
  	remove_column :reminders, :message_id
  	remove_column :reminders, :report_id
  	remove_column :reminders, :program_id
  	remove_column :reminders, :recipient_id
  end
end
