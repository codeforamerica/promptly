class CreateRemindersReportsTable < ActiveRecord::Migration
  def up
  	create_table :reminders_reports, :id => false do |t|
      t.integer :reminder_id
      t.integer :report_id
     end
  end

  def down
  end
end
