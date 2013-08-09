class DropReminderMessageTable < ActiveRecord::Migration
  def up
  	drop_table :messages_reminders
  end

  def down
  end
end
