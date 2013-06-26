class AddMessageTextToReminder2 < ActiveRecord::Migration
  def change
  	add_column :reminders, :message_text, :string
  end
end
