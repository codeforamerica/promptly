class DeleteReportsRemindersTable < ActiveRecord::Migration
  def up
  	drop_table :reports_reminders
  end

  def down
  end
end
