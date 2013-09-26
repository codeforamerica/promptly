class AddStateToReminders < ActiveRecord::Migration
  def change
  	add_column :reminders,  :state, :string
  end
end
