class DeleteProgramIdfromReminders < ActiveRecord::Migration
  def up
  	remove_column :reminders, :program_id
  end

  def down
  end
end
