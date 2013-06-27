class AddProgramIdToReminders < ActiveRecord::Migration
  def change
  	add_column :reminders, :program_id, :integer
  end
end
