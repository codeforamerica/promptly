class AddDatetoRecipients < ActiveRecord::Migration
  def up
  	add_column :recipients, :reminder_date, :datetime
  end

  def down
  end
end
