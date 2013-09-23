class AddGroupIdToReminders < ActiveRecord::Migration
  def change
  	add_column :reminders, :group_ids, :string
  end
end
