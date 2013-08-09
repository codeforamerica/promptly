class DropReminderJoinTables < ActiveRecord::Migration
  def up
  	drop_table :recipients_reminders
  	drop_table :reminders_reports
  	drop_table :programs_reminders
  	drop_table :messages_reminders
  end

  def down
  end
end
