class CreateReportsRemindersTable < ActiveRecord::Migration
  def up
  	create_table :reports_reminders, :id => false do |t|
      t.integer :reminder_id
      t.integer :report_id
     end
  end

  def down
  end
end
