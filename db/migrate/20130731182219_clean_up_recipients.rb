class CleanUpRecipients < ActiveRecord::Migration
  def up
  	add_column :recipients, :name, :string
  	remove_column :recipients, :case
  	remove_column :recipients, :active
  	remove_column :recipients, :reminder_date
  	drop_table :recipients_reports
  	drop_table :programs_recipients
  end

  def down
  end
end
