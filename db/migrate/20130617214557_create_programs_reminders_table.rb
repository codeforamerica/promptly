class CreateProgramsRemindersTable < ActiveRecord::Migration
  def up
  	create_table :programs_reminders, :id => false do |t|
      t.integer :reminder_id
      t.integer :program_id
    end
  end

  def down
  end
end
