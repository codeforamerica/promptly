class AddMessageTextToReminder < ActiveRecord::Migration
  def change
  	remove_column :reminders, :messsage_text, :string
  	add_column :reminders, :message_text, :string
  end
end
