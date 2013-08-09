class ChangeSendDateFieldToDatetime < ActiveRecord::Migration
  def up
  	change_column :deliveries, :send_date, :datetime
  end

  def down
  end
end
